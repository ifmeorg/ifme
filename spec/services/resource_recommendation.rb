class ResourceRecommendation
    def initialize(moment)
        @moment = moment
        @moment_keywords = []
    end

    private

    def all_resources
        JSON.parse(File.read(Rails.root.join('doc', 'pages', 'resources.json')))
    end
end