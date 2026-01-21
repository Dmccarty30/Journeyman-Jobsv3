# Const Opportunities Analyzer for Flutter
# Scans the lib directory and identifies where 'const' can be added

param(
    [string]$OutputDir = ".gemini"
)

$ErrorActionPreference = "Stop"

$mdOutputFile = Join-Path $OutputDir "markdown\const_analysis_report.md"
$htmlOutputFile = Join-Path $OutputDir "html\const_analysis_report.html"

Write-Host "Analyzing Flutter codebase for const opportunities..." -ForegroundColor Cyan

# Get all Dart files excluding generated files
$dartFiles = Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse | Where-Object { 
    $_.FullName -notmatch '\.g\.dart$' -and $_.FullName -notmatch '\\generated\\' 
}

$totalFiles = $dartFiles.Count
Write-Host "Found $totalFiles Dart files to analyze" -ForegroundColor Green

# Initialize results hashtable
$categories = @('Text_Widgets', 'Icon_Widgets', 'SizedBox_Widgets', 'Padding_Widgets', 
    'EdgeInsets', 'TextStyle', 'Divider_Widgets', 'Container_Widgets', 'Row_Column_Widgets')

$results = @{}
foreach ($cat in $categories) {
    $results[$cat] = @()
}

$fileProgress = 0

foreach ($file in $dartFiles) {
    $fileProgress++
    $percentComplete = ($fileProgress / $totalFiles) * 100
    Write-Progress -Activity "Analyzing files" -Status "Processing $($file.Name)" -PercentComplete $percentComplete
    
    try {
        $lines = Get-Content $file.FullName
        $lineCount = $lines.Count
        
        for ($lineIndex = 0; $lineIndex -lt $lineCount; $lineIndex++) {
            $line = $lines[$lineIndex]
            $lineNum = $lineIndex + 1
            
            # Skip if line already has const
            if ($line -match '\bconst\b') { continue }
            
            $relativePath = $file.FullName.Replace((Get-Location).Path + '\', '')
            
            # Check for Text widgets without const
            if ($line -match '^\s+Text\(') {
                $results['Text_Widgets'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
            
            # Check for Icon widgets without const
            if ($line -match '^\s+Icon\(') {
                $results['Icon_Widgets'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
            
            # Check for SizedBox without const
            if ($line -match '^\s+SizedBox\(') {
                $results['SizedBox_Widgets'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
            
            # Check for Padding without const
            if ($line -match '^\s+Padding\(') {
                $results['Padding_Widgets'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
            
            # Check for EdgeInsets without const
            if ($line -match 'EdgeInsets\.' -and $line -notmatch 'const\s+EdgeInsets\.') {
                $results['EdgeInsets'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
            
            # Check for TextStyle without const
            if ($line -match 'TextStyle\(' -and $line -notmatch 'const\s+TextStyle\(') {
                $results['TextStyle'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
            
            # Check for Divider without const
            if ($line -match '^\s+Divider\(') {
                $results['Divider_Widgets'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
            
            # Check for Container (potential candidates)
            if ($line -match '^\s+Container\(') {
                $results['Container_Widgets'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
            
            # Check for Row/Column (potential candidates)
            if ($line -match '^\s+(Row|Column)\(') {
                $results['Row_Column_Widgets'] += [PSCustomObject]@{
                    File = $relativePath
                    Line = $lineNum
                    Code = $line.Trim()
                }
            }
        }
    }
    catch {
        Write-Warning "Error processing file $($file.FullName): $_"
    }
}

Write-Progress -Activity "Analyzing files" -Completed

# Calculate total opportunities
$totalOpportunities = 0
foreach ($cat in $categories) {
    $totalOpportunities += $results[$cat].Count
}

# Generate Markdown Report
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$mdContent = @"
# Const Optimization Analysis Report

**Generated:** $timestamp  
**Total Files Analyzed:** $totalFiles  
**Total Opportunities:** $totalOpportunities

## Executive Summary

This report identifies opportunities to add ``const`` constructors throughout the Flutter codebase.
Adding ``const`` to immutable widgets reduces rebuilds and improves performance.

## Findings by Category

"@

foreach ($category in $categories) {
    $items = $results[$category]
    $count = $items.Count
    
    if ($count -gt 0) {
        $categoryName = $category.Replace('_', ' ')
        $mdContent += "`n### $categoryName ($count opportunities)`n`n"
        
        # Group by file
        $groupedByFile = $items | Group-Object -Property File
        
        foreach ($fileGroup in $groupedByFile) {
            $mdContent += "#### ``$($fileGroup.Name)`` ($($fileGroup.Count) instances)`n`n"
            
            foreach ($item in ($fileGroup.Group | Sort-Object Line)) {
                $mdContent += "- **Line $($item.Line):** ``$($item.Code)```n"
            }
            $mdContent += "`n"
        }
    }
}

$mdContent += "`n## Summary Statistics`n`n"
$mdContent += "| Category | Count |`n"
$mdContent += "|----------|-------|`n"

foreach ($category in $categories) {
    $count = $results[$category].Count
    $categoryName = $category.Replace('_', ' ')
    $mdContent += "| $categoryName | $count |`n"
}

$mdContent += "| **TOTAL OPPORTUNITIES** | **$totalOpportunities** |`n"

$mdContent += @"


## Recommendations

### High Priority (Likely Safe to Add Const)
1. **Text Widgets** - Most static Text widgets can be const
2. **Icon Widgets** - Icons with fixed IconData can be const  
3. **SizedBox** - Spacing boxes with fixed dimensions should be const
4. **Divider** - Static dividers can be const
5. **EdgeInsets** - All EdgeInsets with literal values should be const
6. **TextStyle** - Styles with literal values should be const

### Medium Priority (Requires Verification)
1. **Padding** - Check if padding values are literal
2. **Container** - Only if all properties are const (decoration, padding, etc.)

### Low Priority (Manual Review Needed)
1. **Row/Column** - Only if all children are const

## Next Steps

1. Review each category starting with High Priority items
2. For each instance, verify:
   - All constructor parameters are compile-time constants
   - No dynamic data or variables are used
   - The widget doesn't depend on runtime state
3. Add ``const`` keyword and test the build
4. Run ``flutter analyze`` to catch any invalid const usage

## Notes

- This is an automated analysis and may include false positives
- Always verify before adding ``const`` to ensure correctness
- Some widgets cannot be const if they reference non-const data
- Use IDE hints (VS Code/Android Studio) to validate const-correctness

---
*Generated by Const Opportunities Analyzer*
"@

# Ensure output directories exist
$mdDir = Split-Path $mdOutputFile -Parent
$htmlDir = Split-Path $htmlOutputFile -Parent

if (-not (Test-Path $mdDir)) {
    New-Item -ItemType Directory -Path $mdDir -Force | Out-Null
}

if (-not (Test-Path $htmlDir)) {
    New-Item -ItemType Directory -Path $htmlDir -Force | Out-Null
}

# Save markdown report
$mdContent | Out-File -FilePath $mdOutputFile -Encoding UTF8 -Force

Write-Host "`nMarkdown report saved to: $mdOutputFile" -ForegroundColor Green
Write-Host "Total opportunities found: $totalOpportunities" -ForegroundColor Cyan

# Display summary
Write-Host "`nTop Categories:" -ForegroundColor Yellow
$sortedCategories = $categories | Sort-Object { $results[$_].Count } -Descending
foreach ($category in $sortedCategories) {
    $count = $results[$category].Count
    if ($count -gt 0) {
        $categoryName = $category.Replace('_', ' ')
        Write-Host "  $categoryName : $count" -ForegroundColor White
    }
}

Write-Host "`nAnalysis Complete!" -ForegroundColor Magenta
