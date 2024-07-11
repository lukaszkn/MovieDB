# MovieDB
Now playing movies and search sample app using MVVM-C (with coordinators) and async/await structured concurrency.<br>

The app consist of two screens. The main screen shows list of now playing movies with ability to search for any title.<br>
The second screen shows selected movie details.

The app connects to the rest api to get the list of movies and search for titles.

Jump to

- [Screenshots](#screenshots)
- [Project structure](#project-structure)
- [Tests](#tests)
- [Future work](#future-work)

## Screenshots 

<p>
<img src="screenshots/app1.png" width="300">&nbsp;
<img src="screenshots/app2.png" width="300"><br>
</p>
<p>
<img src="screenshots/app3.png" width="300">&nbsp;<br>
</p>

## Project structure

<table style="border-collapse: collapse; ">
<tr>
<td style="vertical-align: top;">
<img src="screenshots/projectStructure.png" width="370">
</td>
<td style="vertical-align: top;">
Project has 2 main groups: Core and Modules.<br>
App contains main app views along with master detail navigation defined.<br><br>
Modules group contains implementation of movie list, movie details, view models and services.<br>
Potentially, Modules could be moved to separate packages if needed.<br>
<br>
Look inside the code for particular file comment.
</td>
</tr>
</table>

[back to top](#readme)


## Tests

<table style="border-collapse: collapse; ">
<tr>
<td style="vertical-align: top;">
<img src="screenshots/tests.png" width="370">
</td>
<td style="vertical-align: top;">
Project contains unit tests for view models and also for api service live/mock.<br>
Live api service test is done for demo purposes only. The app shouldn't test live api service.
<br>
</td>
</tr>
</table>

[back to top](#readme)

## Future work
Potential future work/discussion/questions:

- Movie details could be loaded with additional call on details screen
- Any errors could present messages to the user
- Search bar could show autocomplete titles however the main list shows filtered search results instead?

[back to top](#readme)