mod = 'xWindowsUpdate'

powershell_script "install-#{mod}" do
  code <<-EOH
  Install-PackageProvider -Name "Nuget" -Force
  Install-Module #{mod} -Force
  $env:PSModulePath = [System.Environment]::GetEnvironmentVariable("PSModulePath","Machine")
  EOH
  guard_interpreter :powershell_script
  not_if "(Get-Module -ListAvailable -Name #{mod}).Name -eq \"#{mod}\""
end

dsc_script 'setup-xWindowsUpdate' do
  imports 'xWindowsUpdate'
  timeout 800
  code <<-EOH
  xWindowsUpdateAgent MuSecurityImportant
  {
    IsSingleInstance = 'Yes'
    UpdateNow        = $true
    Category         = @('Security','Important')
    Source           = 'WindowsUpdate'
    Notifications    = 'Disabled'
  }
  EOH
end
