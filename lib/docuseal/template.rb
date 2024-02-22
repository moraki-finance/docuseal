module Docuseal
  class Template < Model
    def self.path
      "/templates"
    end

    # from: :html, :docx or :pdf
    #
    # https://www.docuseal.co/docs/api#create-a-template-from-html
    # https://www.docuseal.co/docs/api#create-a-template-from-word-docx
    # https://www.docuseal.co/docs/api#create-a-template-from-existing-pdf
    def self.create(from:, **attrs)
      super(path: "#{path}/#{from}", **attrs)
    end

    # https://www.docuseal.co/docs/api#update-template-documents
    def self.update_documents(id, documents: [])
      return if documents.empty?
      response = Docuseal::Client.instance.put(path: "#{path}/#{id}/documents", body: {documents:})
      new(response.body)
    end
  end
end
