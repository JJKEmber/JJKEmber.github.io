$path = Join-Path $PSScriptRoot '..\_posts\2026-09-13-Heavenly-Restriction-.md'
$text = [IO.File]::ReadAllText((Resolve-Path $path))
$classPattern = '(?s)\{\{5e Class Features\r?\n(.*?)\r?\n\}\}'
$classMatch = [regex]::Match($text, $classPattern)
if ($classMatch.Success) {
  $fields = @{}
  foreach ($line in ($classMatch.Groups[1].Value -split '\r?\n')) {
    if ($line -match '^\|([^=]+)=(.*)$') { $fields[$matches[1]] = $matches[2] }
  }
  $rows = @('| Level | Features | Martial Arts | Unarmored Movement | Stamina Points |','| --- | --- | --- | --- | --- |')
  for ($level = 1; $level -le 20; $level++) {
    $features = $fields["classfeatures$level"]
    if ([string]::IsNullOrWhiteSpace($features)) { $features = '' }
    $rows += "| $level | $features | $($fields["extra1_$level"]) | $($fields["extra2_$level"]) | $($fields["extra3_$level"]) |"
  }
  $table = $rows -join "`n"
  $text = $text.Remove($classMatch.Index, $classMatch.Length).Insert($classMatch.Index, "## Heavenly Restriction Class Features`n`n$table")
}
$text = [regex]::Replace($text, '(?s)<div class="externalimage-holder"[^>]*>\s*\{\{5e Image\|float:right\|([^|]+)\|([^}]+)\}\}</div>', '![$2]($1)')
$text = [regex]::Replace($text, '^====(.+?)====\s*$', '#### $1', 'Multiline')
$text = [regex]::Replace($text, '^===(.+?)===\s*$', '### $1', 'Multiline')
$text = [regex]::Replace($text, '^==(.+?)==\s*$', '# $1', 'Multiline')
$text = [regex]::Replace($text, '^;(.+?)\s*$', '### $1', 'Multiline')
$text = [regex]::Replace($text, '\{\{inpage\|([^}]+)\}\}', '$1')
$text = [regex]::Replace($text, '\{\{5a\|([^}]+)\}\}', '$1')
$text = [regex]::Replace($text, '\{\{5e\|([^}|]+)(?:\|([^}]+))?\}\}', { param($m); if ($m.Groups[2].Success) { $m.Groups[2].Value } else { $m.Groups[1].Value } })
$text = [regex]::Replace($text, '\{\{5s\|([^}]+)\}\}', '$1')
$text = [regex]::Replace($text, '\{\{5c\|([^}]+)\}\}', '$1')
$text = [regex]::Replace($text, '\{\{5g\|([^}]+)\}\}', '$1')
$text = [regex]::Replace($text, '\{\{#anc:([^}]+)\}\}', '$1')
$text = [regex]::Replace($text, '\[\[([^\]|]+)\|([^\]]+)\]\]', '$2')
$text = [regex]::Replace($text, '\[\[([^\]]+)\]\]', { param($m); $value = $m.Groups[1].Value; if ($value -match '#') { ($value -split '#')[-1] -replace '_',' ' } else { ($value -replace '^[^:]+:', '') -replace '_',' ' } })
$text = [regex]::Replace($text, '\[https?://[^\s\]]+\]', '')
$text = $text -replace '<br\s*/?>', ''
$text = [regex]::Replace($text, '^\{\|[^\r?\n]*\r?\n', '', 'Multiline')
$text = [regex]::Replace($text, '^\s*\|\+[^|]*\|\s*(.+?)\s*$', '$1', 'Multiline')
$text = [regex]::Replace($text, '^\s*\|-\s*$', '', 'Multiline')
$text = [regex]::Replace($text, '^\s*\|\s*$', '', 'Multiline')
$text = [regex]::Replace($text, '^\|\}\s*$', '', 'Multiline')
$text = [regex]::Replace($text, "'''([^']+)'''", '**$1**')
$text = [regex]::Replace($text, "''([^']+)''", '*$1*')
$text = [regex]::Replace($text, '^\*\*\*([^*]+)\*\*(.*)$', '* **$1**$2', 'Multiline')
$text = [regex]::Replace($text, '^\*([^* ])', '* $1', 'Multiline')
$text = [regex]::Replace($text, '\n{3,}', "`n`n")
$text = $text.TrimEnd() + "`n"
[IO.File]::WriteAllText((Resolve-Path $path), $text, [Text.UTF8Encoding]::new($false))
