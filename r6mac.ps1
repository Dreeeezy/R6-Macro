Add-Type @'
using System;
using System.Runtime.InteropServices;
 
 
public struct Win32
{
	[DllImport("user32.dll")]
	public static extern int GetAsyncKeyState(int KeyStates);
 
	[DllImport("user32.dll")]
	public static extern void mouse_event(int dwFlags, int dx, int dy, int dwData, int dwExtraInfo);
 
}
'@
 
 
Function IsKeyDown($key) {
	return [Convert]::ToBoolean([Win32]::GetAsyncKeyState($key) -band 0x8000)
}
 
$isOn = $true
while (-Not (IsKeyDown 121)) {
    if (IsKeyDown 120) {
        $isOn = !$isOn
        Start-Sleep -m 200
		if(-Not ($isOn)){
			Write-Host "Desativado"
		}else{
			Write-Host "Ativo"
		}
	}
	
	if ($isOn -and (IsKeyDown 1)-and (IsKeyDown 2)){	

        Start-Sleep -m 14
        [Win32]::mouse_event(1, -1,  17, 0, 0)
        Start-Sleep -m 14
        [Win32]::mouse_event(1,  1, -8, 0, 0)

	}
	Start-Sleep -m 1
}
