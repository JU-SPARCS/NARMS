ActiveRecord::Base.class_eval do
  def self.table_name
    name.split("::").map { |package| package.underscore.pluralize }.join("_")
  end
end
