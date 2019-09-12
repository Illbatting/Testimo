﻿function Test-Value {
    [CmdletBinding()]
    param(
        [Array] $Object,
        [string] $TestName,
        [string[]] $Property,
        [Object] $ExpectedValue,
        [string[]] $PropertyExtendedValue,
        [string] $OperationType,
        [int] $Level,
        [string] $Domain,
        [Object] $DomainController,
        [int] $ExpectedCount,
        [string] $OperationResult,
        [scriptblock] $WhereObject,
        [string] $ReferenceID,
        [scriptblock] $OverwriteName,
        [nullable[bool]] $ExpectedOutput
    )
    if ($Object) {
        if ($WhereObject) {
            $Object = $Object | Where-Object $WhereObject
        }
        if ($ExpectedCount) {
            if ($OverwriteName) {
                $TestName = & $OverwriteName
            }
            Test-Me -Object $Object -ExpectedCount $ExpectedCount -OperationType $OperationType -TestName $TestName -Level $Level -Domain $Domain -DomainController $DomainController -Property $Property -ExpectedValue $ExpectedValue -PropertyExtendedValue $PropertyExtendedValue -OperationResult $OperationResult -ReferenceID $ReferenceID -ExpectedOutput $ExpectedOutput
        } else {
            foreach ($_ in $Object) {
                if ($OverwriteName) {
                    $TestName = & $OverwriteName
                }
                Test-Me -Object $_ -OperationType $OperationType -TestName $TestName -Level $Level -Domain $Domain -DomainController $DomainController -Property $Property -ExpectedValue $ExpectedValue -PropertyExtendedValue $PropertyExtendedValue -OperationResult $OperationResult -ReferenceID $ReferenceID -ExpectedOutput $ExpectedOutput
            }
        }
    } else {
        Write-Warning 'Objected not passed to Test-VALUE.'
    }
}