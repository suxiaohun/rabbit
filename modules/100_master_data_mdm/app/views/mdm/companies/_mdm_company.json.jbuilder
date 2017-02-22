json.extract! mdm_company, :id, :code, :name, :corporation, :phone, :email, :created_at, :updated_at
json.url mdm_company_url(mdm_company, format: :json)