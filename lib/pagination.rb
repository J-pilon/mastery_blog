module Pagination
    def paginate(collections:, params: {})
        pagination = Services::Pagination.new(collection, params)

        [
            pagination.metadata,
            pagination.results
        ]
    end
end

module ViewModel
    class Pagination
        DEFAULT = {:page => 1, :per_page => 10}.freeze

        attr_reader :page, :per_page, :count

        def initialize(params = {})
            @page = (params[:page] ||  DEFAULT[:page]).to_i
            @per_page = params[:per_page] || DEFAULT[:per_page]
            @count = params[:count]
        end

        def offset
            return 0 if page == 1

            per_page * (page.to_i - 1)
        end

        def next_page
            page + 1 unless last_page?
        end

        def next_page?
            page < total_pages
        end

        def prev_page
            page - 1 unless first_page?
        end

        def prev_page?
            page > 1
        end

        def first_page?
            page == 1
        end

        def last_page?
            page == total_pages
        end

        def total_pages
            (count / per_page.to_f).ceil
        end
    end
end

module Services
    class Pagination
        attr_reader :collection, :params

        def initialize(collection, params = {})
            @collection = collection
            @params = params.merge(count: collection.size)
        end

        def metadata
            @metadata ||= ViewModel::Pagination.new(params)
        end

        def results
            collection
                .limit(metadata.per_page)
                .offset(metadata.offset)
        end
    end
end






