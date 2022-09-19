Dir[File.dirname(__FILE__) + '/lib/easyredmine_budget_quotas/easy_patch/*/*/*.rb'].each {|file| require_dependency file }

ActionDispatch::Reloader.to_param do
  require_dependency 'easyredmine_budget_quotas/hooks'
end
Rails.logger.warn("#01")

Dir.entries(File.dirname(__FILE__) + '/lib/easyredmine_budget_quotas/easy_patch').each do |file|
    next unless file.end_with?('.rb')
    Rails.logger.warn("#02")
    require_relative "./lib/easyredmine_budget_quotas/easy_patch/#{file}"
end
Rails.logger.warn("#03")

#require_dependency 'easyredmine_budget_quotas/easy_patch/easy_lookup_budget_quota_activity'
EasyExtensions::EasyLookups::EasyLookup.map do |easy_lookup|
  Rails.logger.warn("BEFORE")
  easy_lookup.register 'EasyredmineBudgetQuotas::EasyPatch::EasyLookupBudgetQuotaActivity'
  Rails.logger.warn("AFTER")
end
Rails.logger.warn("#04")

#ModalSelectorsController.send :include, EasyredmineBudgetQuotas::EasyPatch::ModelSelectorControllerExtension
Rails.logger.warn("#05")


EasyTimeEntryQuery.class_eval do
  
  def searchable_columns
    ["comments", "projects.name"]
  end
  Rails.logger.warn("#06")

end
