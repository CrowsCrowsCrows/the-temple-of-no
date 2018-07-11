Those translation files follow the [gettext standard .po file format](https://www.gnu.org/software/gettext/manual/gettext.html#PO-Files).
They can be combined with Twine stories using the
[twine1_localizer.py](https://github.com/Lucas-C/dotfiles_and_notes/blob/master/languages/python/twine1_localizer.py) Python script.

Note that the `build.sh` script at the root of this repository automatically handles the translation step.

## To check if changes in wordings have been made to the original .tws

    twine1_localizer.py diff_tws_and_po the-temple-of-no.tws l10n/en-US.po

If any changes have been made, the text output of this command will details them,
so you can modify the corresponding translations in the other `.po` files.

Then, execute the following command to update `l10n/en-US.po`:

    twine1_localizer.py po_from_tws the-temple-of-no.tws l10n/en-US.po

## To generate a translated .tws file

The following command will create a `the-temple-of-no_fr.tws` file based on the original
`the-temple-of-no.tws` Twine and the translated strings from `l10n/fr-FR.po`:

    twine1_localizer.py translate the-temple-of-no.tws l10n/fr-FR.po the-temple-of-no_fr.tws

## To start a new translation

Execute the following command after substituting the `xx-XX` characters by your new [language tag](http://www.langtag.net),
in order to create a new translation file that will contain all the string IDs
and ther corresponding string message, in English initially:

    twine1_localizer.py po_from_tws the-temple-of-no.tws l10n/xx-XX.po
