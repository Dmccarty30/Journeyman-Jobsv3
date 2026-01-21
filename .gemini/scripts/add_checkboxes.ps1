$filePath = ".gemini\markdown\const_analysis_report.md"
$content = Get-Content $filePath
$newContent = foreach ($line in $content) {
    if ($line -match '^- \*\*Line') {
        $line -replace '^- ', '- [ ] '
    }
    else {
        $line
    }
}
$newContent | Set-Content $filePath -Encoding UTF8
Write-Host "Checkboxes added successfully."
