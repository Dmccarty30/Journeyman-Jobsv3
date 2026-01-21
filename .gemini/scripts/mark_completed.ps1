$filePath = ".gemini\markdown\const_analysis_report.md"
$content = Get-Content $filePath

$newContent = $content | ForEach-Object {
    if ($_ -match 'lib\\core\\widgets\\offline_indicator\.dart' -and $script:currentFile -ne 'offline_indicator') {
        $script:currentFile = 'offline_indicator'
    } elseif ($_ -match 'lib\\core\\widgets\\notification_popup\.dart' -and $script:currentFile -ne 'notification_popup') {
        $script:currentFile = 'notification_popup'
    } elseif ($_ -match 'lib\\core\\services\\notification_permission_service\.dart' -and $script:currentFile -ne 'notification_permission') {
        $script:currentFile = 'notification_permission'
    } elseif ($_ -match '####') {
        $script:currentFile = ''
    }

    if ($script:currentFile -eq 'offline_indicator') {
        if ($_ -match 'Line 89' -or $_ -match 'Line 142' -or $_ -match 'Line 284' -or $_ -match 'Line 314' -or $_ -match 'Line 332') {
             $_ -replace '\[ \]', '[x]'
        } else { $_ }
    } elseif ($script:currentFile -eq 'notification_popup') {
        if ($_ -match 'Line 258' -or $_ -match 'Line 280') {
             $_ -replace '\[ \]', '[x]'
        } else { $_ }
    } elseif ($script:currentFile -eq 'notification_permission') {
        if ($_ -match 'Line 160') {
             $_ -replace '\[ \]', '[x]'
        } else { $_ }
    } elseif ($script:currentFile -eq 'auth_screen') {
        # Line 283 was reverted by user
        $_
    } else {
        $_
    }
}

$newContent | Set-Content $filePath -Encoding UTF8
Write-Host "Report updated with progress."
