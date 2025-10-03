Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition @'
using System;
using System.Runtime.InteropServices;
public static class NativeMethods {
    [DllImport("user32.dll")]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
}
'@

$proc = Get-Process -Name steam -ErrorAction SilentlyContinue
if ($proc) {
    $h = $proc.MainWindowHandle
    if ($h -ne 0) {
        # 0x0001 = SWP_NOSIZE, 0x0040 = SWP_SHOWWINDOW
        [Win32.NativeMethods]::SetWindowPos([IntPtr]$h, [IntPtr]::Zero, 100, 100, 0, 0, 0x0001 -bor 0x0040) | Out-Null
        Write-Host "Spróbowałem przesunąć okno Steam na pozycję (100,100)."
    } else {
        Write-Host "Nie znaleziono uchwytu okna (MainWindowHandle = 0). Spróbuj Shift+PrawyKlik na pasku zadań lub Alt+Space."
    }
} else {
    Write-Host "Proces Steam nie uruchomiony."
}

#Skrypt na przykładzie steama wymusza przywrócenie okna, które znajduje się w pasku zadań ale nie wyświetla się, częsty problem w Windowsie
