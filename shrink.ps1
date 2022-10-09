Add-Type -AssemblyName System.Windows.Forms
[void][Reflection.Assembly]::LoadWithPartialName(“System.Drawing”)

$cbImage = [System.Windows.Forms.Clipboard]::GetImage()
If ($cbImage -ne $null)
{
  $ratio = 71   # Shriink/Expand ratio: This setting shrink the original image to 71%.
  $ratio = $ratio / 100
  $newWidth = [int]($cbImage.Width * $ratio)    # Change this setting
  $newHeight = [int]($cbImage.Height * $ratio)  # if you change the aspect ratio
  $bmImage = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
  $newImage = [System.Drawing.Graphics]::FromImage($bmImage)
  $newImage.DrawImage($cbImage, $(New-Object -TypeName System.Drawing.Rectangle -ArgumentList 0, 0, $newWidth, $newHeight))
  [Windows.Forms.Clipboard]::SetImage($bmImage)

  $cbImage.Dispose()
  $bmImage.Dispose()
  $newImage.Dispose()
}
