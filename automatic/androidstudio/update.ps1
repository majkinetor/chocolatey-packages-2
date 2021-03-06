import-module au

$releases = 'https://developer.android.com/studio/#downloads'


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
    $regex = '.exe$'
    $url = $download_page.links | ? href -match $regex | select -First 1 -Skip 1 -expand href
       
    $version = $url -split '/' | select -Last 1 -Skip 1
    $build = $url -split '-' | select -Last 1 -Skip 1
    
    return @{ URL64 = $url; Version = $version; }
}

update -ChecksumFor 64
