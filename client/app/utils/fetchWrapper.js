/**
 * A lightweight fetch wrapper that mimics the axios API surface used in this
 * project, allowing us to remove the axios dependency while keeping the same
 * call signatures across the codebase.
 *
 * Supported methods: get, post, put, delete
 * Global headers (e.g. CSRF token) can be set via fetchWrapper.defaults.headers.common
 */

/**
 * Parses the response and throws a descriptive error for non-2xx status codes.
 * Safely handles non-JSON responses by checking the content-type header first.
 */
const handleResponse = async (response) => {
  const isJson = response.headers.get('content-type')?.includes('application/json');
  const data = isJson ? await response.json() : null;

  if (!response.ok) {
    const error = (data && data.message) || response.statusText || response.status;
    throw new Error(error);
  }

  return { data };
};

export const fetchWrapper = {
  // Mirrors axios.defaults.headers.common — headers set here are sent with every request
  defaults: {
    headers: {
      common: {},
    },
  },

  /**
   * Base request method. Merges global headers with per-request headers,
   * serializes the body as JSON when present, and delegates response
   * handling to handleResponse.
   */
  request: async (method, url, body = null, extraHeaders = {}) => {
    const config = {
      method,
      headers: {
        ...fetchWrapper.defaults.headers.common,
        ...extraHeaders,
      },
    };

    if (body) {
      config.headers['Content-Type'] = 'application/json';
      config.body = JSON.stringify(body);
    }

    return handleResponse(await fetch(url, config));
  },

  get: (url, headers) => fetchWrapper.request('GET', url, null, headers),
  post: (url, body, headers) => fetchWrapper.request('POST', url, body, headers),
  put: (url, body, headers) => fetchWrapper.request('PUT', url, body, headers),
  patch: (url, body, headers) => fetchWrapper.request('PATCH', url, body, headers),
  delete: (url, headers) => fetchWrapper.request('DELETE', url, null, headers),
};
