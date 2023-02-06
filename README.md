# findlog

Addon that allows you to search through the chatlogs produced by Atom0s's logs addon (assumes the default Ashita\chatlogs directory and naming scheme of <charname>_YYYY.MM.DD.log).

You can use `/findlog <string>` or `/fl <string>` to search for and print a matching string; `/flcount <string>` will give you a count of lines that match the search string.

The addon will also keep track of Dynamis currency as it drops; you can type `/dynalist` to print a list of currency that has dropped and who obtained it (also gives a total). (The command `dynacount` does the same thing, but parses through the log file instead, which can be useful if you disconnected or crashed while in Dynamis, as a client crash would cause the addon to unload and the currency table would no longer have record of prior currency drops.)
