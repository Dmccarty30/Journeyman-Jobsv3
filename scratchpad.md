# SCRATCHPAD

## APP WIDE CHANGES

## HOME SCREEN

- [x] On the home screen, specifically the `job cards` i want them to look exactly like the job cards on the **job screen**. Where there is an icon at the beginning of each row. For example, there is a 'dollar' icon at the beginning of the row that has the `wages` amount. There is a 'clock' at the beginning of the row for `hours`.. etc.
  - *Status: Completed. Replaced CondensedJobCard with RichTextJobCard which contains the requested icon-led layout.*

## JOB SCREEN

## STORM SCREEN

- [x] The background on the storm screen is dark. I need it to be light.
  - *Status: Completed. Updated background to off-white and adjusted ElectricalCircuitBackground for a light theme.*

## CREWS SCREEN

## SETTINGS SCREEN

## LOCALS SCREEN

- [x] The cards on the locals screen look like dark mode is turned on. I need for them to look like all of the other cards in the app with a white background and copper border
  - *Status: Completed. Explicitly set white background and copper borders for LocalCard and LocalDetailsDialog.*

## TODO / REMAINING ISSUES
- [ ] Fix potential type mismatch in `home_screen.dart` (analysis reporting `Job` vs `JobsRecord` conflict in `_showJobDetailsDialog`).