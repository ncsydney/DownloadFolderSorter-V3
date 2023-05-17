function SortFiles {
    Param(
        [Parameter(Mandatory=$true)]
        [string[]]
        $RelativeDownloadPath,

        [Parameter(Mandatory=$true)]
        [string[]]$specifiedArray,

        [Parameter(Mandatory=$true)]
        [string[]]$dirName
    )
    
    $DownloadPath = Get-ChildItem -Path $RelativeDownloadPath | Where-Object {!$_.PSIsContainer}

    $MovedItems = @()

    foreach($dir in $Paths){
        if(!(Test-Path("$RelativeDownloadPath\$dir"))) {
            New-Item -Path $RelativeDownloadPath -Name $dir -ItemType Directory
            Write-Host "Created path $dir" -ForegroundColor Green
        }
    }        
    try{
        # Check for speficied files, if they exist, move them
        $count = 0
        foreach($file in $DownloadPath){
            foreach($Xtension in $Specified_array){
                if($file.Extension -eq ".$Xtension"){
                    Move-Item -Path $file.FullName -Destination "$RelativeDownloadPath\$dirName" -ErrorAction SilentlyContinue
                    $MovedItems += $file.FullName
                    $count++
                }
            }
        }
        if($count -ge 1){
            Write-Host "Moved $count file(s) to $RelativeDownloadPath\$dirName -ForegroundColor Green"
            $MovedItems
        }
    }
    catch{""}
}

# Output folders for files
$Paths = @("Video","Foto","Programs","3D-Files","Programming", "Iso", "Compressed")

$VideoFmt = @("mp4","h264","h265","x264","x265","mkv", "flv", "webm")
$PhotoFmt = @("jpeg","jpg","png","gif","webp")
$ProgramFmt = @("exe","msi")
$3DFmt = @("stl","3mf","gcode")
$ProgrammingFmt = @("py","ps1","js","ts","c","cs","cpp","sh","java")
$OSExtentions = @("iso")
$CompressedDirs = @("7z","rar","zip","gz")

SortFiles -RelativeDownloadPath "C:\Users\$Env:UserName\Downloads" -specifiedArray $VideoFmt -dirName $Paths[0] #"Video"
SortFiles -RelativeDownloadPath "C:\Users\$Env:UserName\Downloads" -specifiedArray $PhotoFmt -dirName $Paths[1] #"Foto"
SortFiles -RelativeDownloadPath "C:\Users\$Env:UserName\Downloads" -specifiedArray $ProgramFmt -dirName $Paths[2] #"Programs"
SortFiles -RelativeDownloadPath "C:\Users\$Env:UserName\Downloads" -specifiedArray $3DFmt -dirName $Paths[3] #"3D-Files"
SortFiles -RelativeDownloadPath "C:\Users\$Env:UserName\Downloads" -specifiedArray $ProgrammingFmt $Paths[4] -dirName #"Programming"
SortFiles -RelativeDownloadPath "C:\Users\$Env:UserName\Downloads" -specifiedArray $OSExtentions -dirName $Paths[5] #"Iso"
SortFiles -RelativeDownloadPath "C:\Users\$Env:UserName\Downloads" -specifiedArray $CompressedDirs -dirName $Paths[6] #"Compressed"
