function Get-FileInvokeWebRequest{
    param(
        [Parameter(Mandatory=$true)]
        $url, 
        $destinationFolder="$env:USERPROFILE\Downloads", 
        [switch]$includeStats
    )
    $destination = Join-Path $destinationFolder ($url | Split-Path –Leaf)
    $start = Get-Date
    Invoke-WebRequest $url –OutFile $destination
    $elapsed = ((Get-Date) – $start).ToString('hh\:mm\:ss')
    $totalSize = (Get-Item $destination).Length | Get-FileSize
    if ($includeStats.IsPresent){
        [PSCustomObject]@{Name=$MyInvocation.MyCommand;TotalSize=$totalSize;Time=$elapsed}
    }
    Get-Item $destination | Unblock-File
}
