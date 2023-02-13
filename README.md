# notepad--

Notepad-- is the perfect note-taking solution that lets you focus on what matters most—your observations. With a minimalist interface and no distracting ads, you can easily open the app and start signing up. Plus, you don't have to worry about spending money and it's very easy to set up. And if you need to save your work, Notepad even provides CSV output. [Download] now and experience the ease of taking notes.

* Timestamps accurate to milliseconds
* CSV text format
* Flexible setup
* ✨ Magic hotkeys for superfast typing✨

[Release history]

## Installation

Windows only, but not forever!

[Portable version] - Download on your PC and extract from archive or

[Windows installer] - Picking next> next> next> and make it fun!

## Configuration
To customize your coding scheme, you can select **File->Edit Config** or manually edit the config.ini file in the program file folder. There are two sections, *Basic* with basic functions' editor, and *Key* section for log customization:
~~~
[Basic]
IsIntro=True
TimeOffset=0
BlocksCounts=1
Separator=;
FontName=Ebrima
FontSize=11
FontWeight=100
FontAttribute=0
[Keys]
F5=Behavior
~~~
A standard ini file looks like:
[SectionName]
Key=Value

*IsIntro*: If set to True, a header will be automatically added at the beginning of the protocol that includes the date, time, author, study name, and a transcript header. If you plan to automate the processing of protocols, it is recommended to set this parameter to False.

*TimeOffset*: This allows you to set a time offset relative to the actual time. For instance, if the protocol is being broadcasted live with a known delay time, the time offset can be adjusted accordingly (it will be included in the next release).

*BlocksCounts*: The number of blocks between the timestamp and comment (it will be included in the next release).

*Separator*: The separator used to divide blocks of text.

*FontName*: [The font] used in the report. It is recommended to install the font that you plan to use in the report to avoid any convertation. This is particularly important if you plan to use quotes in the future.

*FontSize*: The font size (default is 11). It is suggested to set the size that you intend to use in the final report.

*FontWeight*: The font weight ranging from 0 to 1000. For example, 400 represents normal weight and 700 represents bold weight.

*FontAttribute*: The attributes of the font, which can be a combination of the following:
>0 = Normal
>2 = Italic
>4 = Underlined
>8 = Strike

The **[Key]** Section is vivid magic! 
~~~
[Keys]
F5=Behavior
~~~
In this particular example, the F5 Key serves as a shortcut for logging participant behavior. By pressing the F5 button, the text "behavior" will appear, allowing you to describe the participant's behavior at a specific time. You may wonder if it's magical - indeed, it is✨ You can create a list of similar markers and access them quickly. I have included the most common markers in the [default] configuration.

## Tech

[AutoIt v3.3.14.5] - AutoIt v3 freeware BASIC-like scripting language 

## Feedback

Test and [send me] not only bugs but also wishes, best wishes;)

## License

MIT


**Free Software, Hell Yeah!**

   [AutoIt v3.3.14.5]: <https://www.autoitscript.com>
   [Download]: <https://github.com/artsiomaheyeu/notepad--/raw/2bb8f9ecf59700adec713e20440eb4e17b5d6772/build/Notepadmm_WIN1.0_setup.exe>
   [Release history]: <https://github.com/artsiomaheyeu/notepad--/blob/23d5480f820d5e2f38a8d65a4a07269b36823d61/build/release_note.txt>
   [Portable version]: <https://github.com/artsiomaheyeu/notepad--/blob/main/build/Notepadmm_WIN1.0.zip>
   [Windows installer]: <https://github.com/artsiomaheyeu/notepad--/blob/main/build/Notepadmm_WIN1.0_setup.exe>
   [The font]: <https://learn.microsoft.com/en-us/typography/fonts/windows_10_font_list>
   [default]: <https://github.com/artsiomaheyeu/notepad--/blob/23d5480f820d5e2f38a8d65a4a07269b36823d61/source/config.ini>
   [send me]: <https://www.linkedin.com/in/artiomageev>
