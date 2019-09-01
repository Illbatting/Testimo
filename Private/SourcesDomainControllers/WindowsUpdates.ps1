﻿$WindowsUpdates = @{
    Enable = $true
    Source = @{
        Name       = "Windows Updates"
        Data       = {
            Get-HotFix -ComputerName $DomainController | Sort-Object -Property InstalledOn -Descending | Select-Object -First 1
        }
    }
    Tests  = [ordered] @{
        PasswordLastSet = @{
            Enable      = $true
            Name        = 'Last Windows Updates should be less than X days ago'
            Parameters  = @{
                Property      = 'InstalledOn'
                ExpectedValue = '(Get-Date).AddDays(-60)'
                OperationType = 'gt'
            }
        }
    }
}