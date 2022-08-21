# Guide for Contributors

## Licensing

When contributing to this book you agree to license your contribution under
compatible licenses (GPL-3.0-or-later and additional CC0-1.0 for code
examples). If your contributions are substantial you will be listed in the
"Thank You!" chapter.

## General guidelines

The following list is non exhaustive. Use your common sense in situation not
listed below and in case of disagreements the list will be updated. If you
strongly disagree with an existing guideline open an issue.

Your changes should work with the newest version of TeXLive distributions. Use
`tlmgr update --all` to make sure the installed packages up to date.

Your changes should be proposed via pull requests, so that they can be easily
reviewed.

## File formatting

- Formatting is generally handled by `latexindent`, make sure to use it before
  committing.
- Lines should not exceed 80 characters, though this is not a hard rule. You
  can ignore it especially in the case of tables.
- Every file should end with a single new line character.

## Text

- Use American spelling for words, for example, center instead of centre.
- Chapter and section titles are using [title case][title case], that is, "Like
  This" and not "Like this".
- Use [serial comma][serial comma], when enumerating things, for example, "I
  like chocolate, candies, and lollipops".
- Use `\enquote` for quotations instead of ``` `` ``` and `''`.
- When quoting things, use the "logical" or ["British" style][quote style] for
  quotations, that is, "like this", and not "like this."
- When speaking in first person use the plural form, for example, "We recommend
  you to use this tool".
- If a sentence contains a phrase in parentheses, the punctuation should be
  placed outside the parentheses (like this). (If full sentences are bracketed,
  the punctuation should stay inside.)

[quote style]:
    https://en.wikipedia.org/wiki/Quotation_marks_in_English#British_practice
[serial comma]: https://en.wikipedia.org/wiki/Serial_comma
[title case]: https://en.wikipedia.org/wiki/Title_case
