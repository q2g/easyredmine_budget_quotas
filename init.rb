require 'redmine'

Redmine::Plugin.register :easyredmine_budget_quotas do
  name 'BudgetQuotas for EasyRedmine'
  author 'Florian Eck for akquinet'
  description 'Keep track of assigned budgets and quotas for spent time/money on projects'
  version '2.0'

  project_module :budget_quotas do
    permission :edit_settings, :budget_quotas => :settings
  end

end

require_relative 'lib/easyredmine_budget_quotas'
require_relative 'lib/easyredmine_budget_quotas/project_budget_quota'
require_relative 'lib/easyredmine_budget_quotas/time_entry_validation'
require_relative 'lib/easyredmine_budget_quotas/hooks'



Rails.application.config.after_initialize do
  Project.send(:include, EasyredmineBudgetQuotas::ProjectBudgetQuota)
  TimeEntry.send(:include, EasyredmineBudgetQuotas::TimeEntryValidation)
end
