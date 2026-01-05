# SCRATCHPAD

## HOME SCREEN

## JOB SCREEN

## CREWS

* When I navigate to the tailboard screen it still takes a while to load.

* When creating a new crew, remove the 'minimum wage selector' thing from the `create crew` popup it is set from the jobs preferences popup.

* In the `job preferences` popup, remove the following choices from the `classification` dropdown:
    * Electrical foreman
    * Project Manager
    * Electrical Engineer
    * Safety Coordinator
    * Estimator
    * Service Technician
    * Maintenance Electrician

* In the `job preferences` popup, remove the 'Preferred Company' section. And replace it with a 'Preferred Locals' section. This section should have a `text input`widget and the 'Foreman' will input the locals manually. (this should be a comma separated list of local numbers) and can be edited at any later point  by the Foreman in the `crew settings` popup.

* In the `Required Skills` section of the `job preferences` popup, remove the following choicechips:
    * Motor Control
    * Fiber Optics
    * Safety Training
    * SCADA Systems
    * PLC Programming
    * Welding

* **WHEN I PRESSED THE 'SAVE PREFERENCES' BUTTON TO FINALIZE THE CREW SETUP, I GOT AN ERROR @crew_preferences_error.png. BE SURE TO CHECK THE FIRESTORE LOGIC TO SEE IF THE CREW PREFERRENCES ARE BEING SAVED CORRECTLY.**

* Also, this is the terminal output.

```terminal

W/.journeymanjobs( 7450): Reducing the number of considered missed Gc histogram windows from 111 to 100
W/.journeymanjobs( 7450): ApkAssets: Deleting an ApkAssets object '<empty> and /product/app/talkback/talkback.apk' with 1 weak references
W/.journeymanjobs( 7450): ApkAssets: Deleting an ApkAssets object '/vendor/overlay/EmulatorTalkBackOverlay/EmulatorTalkBackOverlay.apk' with 1 weak references
D/EGL_emulation( 7450): app_time_stats: avg=40900.05ms min=16.27ms max=163086.88ms count=4
D/EGL_emulation( 7450): app_time_stats: avg=50.19ms min=7.06ms max=1421.39ms count=42
D/EGL_emulation( 7450): app_time_stats: avg=412.66ms min=12.19ms max=15465.84ms count=39
D/EGL_emulation( 7450): app_time_stats: avg=18.17ms min=13.67ms max=101.55ms count=55
I/ImeTracker( 7450): com.mccarty.journeymanjobs:e318c7e9: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InputMethodManager( 7450): showSoftInput() view=io.flutter.embedding.android.FlutterView{efc1178 VFE...... .F...... 0,0-1080,1920 #1 aid=1073741824} flags=0 reason=SHOW_SOFT_INPUT
W/WindowOnBackDispatcher( 7450): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@9dfc38f
D/InputConnectionAdaptor( 7450): The input method toggled cursor monitoring on
D/EGL_emulation( 7450): app_time_stats: avg=26.37ms min=8.34ms max=301.11ms count=38
D/InsetsController( 7450): show(ime(), fromIme=true)
D/EGL_emulation( 7450): app_time_stats: avg=94309.16ms min=1.43ms max=1037037.75ms count=11
W/Firestore( 7450): (26.0.2) [WriteStream]: (574bf7a) Stream closed with status: Status{code=NOT_FOUND, description=No document to update: projects/journeyman-jobs/databases/(default)/documents/crews/Book 2 Raiders-1767618909816, cause=null}.
I/ImeTracker( 7450): com.mccarty.journeymanjobs:e318c7e9: onShown
D/EGL_emulation( 7450): app_time_stats: avg=24.42ms min=13.01ms max=83.99ms count=41
D/EGL_emulation( 7450): app_time_stats: avg=3.62ms min=2.04ms max=27.49ms count=60
D/EGL_emulation( 7450): app_time_stats: avg=7.02ms min=1.97ms max=22.31ms count=59
D/EGL_emulation( 7450): app_time_stats: avg=16.71ms min=10.63ms max=24.16ms count=61
D/EGL_emulation( 7450): app_time_stats: avg=16.51ms min=12.67ms max=19.45ms count=61
D/EGL_emulation( 7450): app_time_stats: avg=48.68ms min=10.30ms max=498.10ms count=28
D/EGL_emulation( 7450): app_time_stats: avg=500.49ms min=484.38ms max=516.60ms count=2
D/EGL_emulation( 7450): app_time_stats: avg=499.66ms min=498.98ms max=500.67m

```
