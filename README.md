# README

**This is a simple one page app to help filter job postings on LinkedIn** 

Steps: 

1. Search for jobs with a keyword on LinkedIn like you normally would. Remember to include any filters you desire.
2. Click search.
3. Copy the entire URL including the protocol portion ("https://")
4. Copy the URL into your text editor.
5. Get rid of the refresh=true portion of the query params
6. Paste over the existing URL on line 7 inside of the index method in the WelcomeController, but leave the last query param from the existing URL!!! (&start=#{start_val}. This must remain in order for proper functionality.
7. Fire up your rails server
8. Open up a new tab in your browser
9. Navigate to localhost:3000
10. Wait...for a while. Do not close the tab or the server.
11. See links containing your results and no BS!
