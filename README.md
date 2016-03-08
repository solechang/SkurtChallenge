# SkurtChallenge

Instructions:
1.) Download the zip and open SkurtChallenge.xcworkspace
2.) Run app in Xcode
3.) Enter following info: a.) Flight number, b.) Carrier Code, c.) Departing or Arriving, d.) Choose Date
- Example
    - Flight number: 231
    - Carrier Code: VX
    - Departing
    - Today’s date
4.) Press Done
	- Status screen will be segued of the flight result
5.) Press ‘Save’ to save the flight status
6.) Go back to Flight Status Screen
7.) Click on ‘Saved Flights’ button on the top left
8.) Delete saved flight if not needed

Notes:
The project will check if user did not input the correct data and alert user to input everything correctly. In addition, I have used auto layout via Storyboard to fit everything accordingly into the screen. I have also used MagicalRecord to save the results and users can delete their saved flight. As for animation, I have included the refreshing indicator when the app is searching for the flight status and included SVProgressHUD that alerts user when the flight status is saved.


Say that I would have of included if I had month of time to develop app, I would improve:
- Making the SkurtChallenge app look like the original Skurt app
    - Including tab options of Flight Status, Saved Flights
    - using: https://github.com/pkluz/PKRevealController
- Options for adding more than 1 saved flight
    - Because users can have multiple flights in a week and want to schedule ahead
- Displaying actual and scheduled departure/arrival dates in the results of the flight
- Using manager to extract data in a clean and easier manner from flight status results and store into Core data using MagicalRecords
- Alert user which input is bad when the search result fails
    - For example, display and highlight textfield in red that the input is bad of either Flight Number or Carrier Code
- Color coordination of the status of the flight
    - For example, landed flights should be displayed in green for good status indication; meanwhile, canceled flights should be displayed in red
- Way later improvements that can be included:
    - Including a map of airport when user is in the vicinity of the airport to confirm location