# manpage-viewer
Basic Lazarus example project to showcase the use of some basic components.
Mainly the *RunCommand* function to execute commands and work with the retrieved output.

The application checks all existing executables (unix only) in /bin and populates a TListBox with them:
![TListBox and TListFilterEdit](https://raw.githubusercontent.com/yet-another-alex/manpage-viewer/master/screens/viewer1.png)

The TListBox is connected to a TListFilterEdit to enable searching on systems with many executables.

On click, the Listener executes another command an populates the TMemo with the manpage of the command:
![Output into TMemo](https://raw.githubusercontent.com/yet-another-alex/manpage-viewer/master/screens/viewer2.png)

Finally, there is a TSaveDialog with a generated filename to enable exporting the entirety of the manpage as textfile.

Obviously, this is not a useful application - it's meant to be a beginner level example, that's hopefully helpful to someone.
