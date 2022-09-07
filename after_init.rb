Dir[File.dirname(__FILE__) + '/lib/easyredmine_budget_quotas/easy_patch/*/*/*.rb'].each {|file| require_dependency file }

require_dependency File.dirname(__FILE__) + '/lib/easyredmine_budget_quotas/easy_patch/easy_lookup_budget_quota_activity'
require_dependency File.dirname(__FILE__) + '/lib/easyredmine_budget_quotas/easy_patch/easy_activity_query'
require_dependency File.dirname(__FILE__) + '/lib/easyredmine_budget_quotas/easy_patch/modal_selector_controller_extension'

RedmineExtensions::Reloader.to_prepare do
  require_dependency 'easyredmine_budget_quotas/hooks'
end

EasyExtensions::EasyLookups::EasyLookup.map do |easy_lookup|
  easy_lookup.register EasyPatch::EasyLookupBudgetQuotaActivity.new
end

ModalSelectorsController.send :include, EasyPatch::ModelSelectorControllerExtension


EasyTimeEntryQuery.class_eval do
  
  def searchable_columns
    ["comments", "projects.name"]
  end
  
end
