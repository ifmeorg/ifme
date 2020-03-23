// @flow
import * as jstz from 'jstimezonedetect';
import Cookies from 'js-cookie';

Cookies.set('timezone', jstz.determine().name());
