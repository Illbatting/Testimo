﻿$Sites = @{
    Enable = $true
    Source = [ordered] @{
        Name       = 'Sites Verification'
        Data       = {
            $ADModule = Import-Module PSWinDocumentation.AD -PassThru
            $Sites = & $ADModule { Get-WinADForestSites }

            [Array] $SitesWithoutDC = $Sites | Where-Object { $_.DomainControllersCount -eq 0 }
            [Array] $SitesWithoutSubnets = $Sites | Where-Object { $_.SubnetsCount -eq 0 }

            [PSCustomObject] @{
                SitesWithoutDC          = $SitesWithoutDC.Count
                SitesWithoutSubnets     = $SitesWithoutSubnets.Count
                SitesWithoutDCName      = $SitesWithoutDC.Name -join ', '
                SitesWithoutSubnetsName = $SitesWithoutSubnets.Name -join ', '
            }
        }
        Details = [ordered] @{
            Area             = ''
            Explanation      = ''
            Recommendation   = ''
            RiskLevel        = 10
            RecommendedLinks = @(

            )
        }
    }
    Tests  = [ordered] @{
        SitesWithoutDC      = @{
            Enable      = $true
            Name        = 'Sites without Domain Controllers'
            Description = 'Verify each `site has at least [one subnet configured]`'
            Parameters  = @{
                Property      = 'SitesWithoutDC'
                ExpectedValue = 0
                OperationType = 'eq'
                #PropertyExtendedValue = 'SitesWithoutDCName'
            }
        }
        SitesWithoutSubnets = @{
            Enable     = $true
            Name       = 'Sites without Subnets'
            Parameters = @{
                Property      = 'SitesWithoutSubnets'
                ExpectedValue = 0
                OperationType = 'eq'
                #PropertyExtendedValue = 'SitesWithoutSubnetsName'
            }
        }
    }
}