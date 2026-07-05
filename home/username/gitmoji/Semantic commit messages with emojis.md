# Semantic Commit Messages with Emojis

Forked from the [original GitHub gist](https://gist.github.com/alpteo/e93d754e5e09907c6362c4230fb66f87), authored by [Alper Teoman](https://github.com/alpteo).

Updated by me to ensure, notwithstanding the [*Conventional Commits*](https://www.conventionalcommits.org/en/v1.0.0/) canon, the strict adherence to the rules of formal English grammar, with the use of elegant, Piltovan, refined, and sophisticated terms, as well as the coding precepts set forth herein. It likewise incorporates, where requisite, my custom commit types and emojis as enumerated within the «`/home/gusbemacbe/.gitmoji/gitmojis.json`» register.

The commit format: `<emoji_type> <commit_type>(<scope>): <subject>. <issue_reference>`

## Example

![Semantic commit message with emoji example image]("Example of semantic commit message with emoji.svg")

**The basic commit message, based upon the *Conventional Commits* canon, will be:**

> feat: Adding a new feature

**With options of emoji, scope, and issue reference:**

> ✨ feat(Component): Adding a new feature. Closes: #..

## Commit Message Types

- **build**/**conf**: changes related to the build system (involving configurations, the scripts) and package dependencies
- **chore**: updating the grunt tasks, etc. (No production code change)
- **ci**: changes related to the continuous integration and deployment system
- **docs**: adding or updating the documentation
- **feat**: introducing a new feature to the codebase
- **fix**: fixing a bug in the codebase
- **perf**: changes related to backward-compatible performance improvements
- **refactor**: refactoring the production code
- **style**: improving the structure or format of the code, for example, missing semicolons. (No production code change)
- **test**: adding the tests. (No production code change)

### Bespoken and personal commit message types

- **access**: improving the accessibility
- **add**: adding a dependency
- **assets**: adding or updating the assets
- **comment**: adding or updating the comments in the source code
- **contributor**: adding or updating the contributor(s)
- **construction**: working in progress
- **database**: performing the database-related changes
- **deprecation**: deprecating the code that needs to be cleaned up
- **deploy**: deploying the stuff
- **folder**: creating, preserving or updating a folder or a submodule
- **friendly**: improving the user experience or usability
- **downgrade**: downgrading a dependency or a version
- **i18n**: changes related to the internationalization and localisation
- **inaugural**: beginning a project
- **log**: adding or updating the logs
- **lucky**: adding or updating an easter egg
- **misspelt**: fixing a typo
- **mute**: removing the logs
- **package**: adding or updating the files or packages
- **picture**: adding or updating one or more images and/or photos
- **redesign**: changes related to the UI, UX and the style file
- **relocate**: moving or renaming the files, paths, or routes
- **remove**: removing a dependency
- **mobile**: changes related to the responsive design
- **screenshot**: adding or updating the snapshots
- **security**: changes related to the security issues
- **seo**: improving the SEO
- **tag**/**version**: `release` or `version` tags
- **text**: adding or updating the texts and the literals
- **upgrade**: upgrading a dependency or a version
- **video**: adding one or more GIFs or videos

## Supported Emojis by Commit Message Types

### Official

| Type     | Emoji | Code                    |
|----------|:-----:|-------------------------|
| build    |  👷   | `:construction_worker:` |
| chore    |  🔧   | `:wrench:`              |
| ci       |  💚   | `:green_heart:`         |
| docs     |  📝   | `:memo:`                |
| feat     |  ✨   | `:sparkles:`            |
| fix      |  🐛   | `:bug:`                 |
| perf     |  ⚡️   | `:zap:`                 |
| refactor |  ♻️   | `:recycle:`             |
| style    |  🎨   | `:art:`                 |
| test     |  ✅   | `:white_check_mark:`    |

### Bespoken and personal

| Type         | Emoji | Code                     |
|--------------|:-----:|--------------------------|
| access       |  ♿️   | `:wheelchair:`           |
| add          |  ➕   | `:heavy_plus_sign:`      |
| assets       |  🍱   | `:bento:`                |
| comment      |  💡   | `:bulb:`                 |
| contributor  |  👥   | `:busts_in_silhouette:`  |
| construction |  🚧   | `:construction:`         |
| database     |  🗃️   | `:card_file_box:`        |
| deprecation  |  🗑️   | `:wastebasket:`          |
| deploy       |  🚀   | `:rocket:`               |
| downgrade    |  ⬇️   | `:arrow_down:`           |
| folder       |  📁   | `:file_folder:`          |
| friendly     |  🚸   | `:children_crossing:`    |
| i18n         |  🌐   | `:globe_with_meridians:` |
| inaurgural   |  🎉   | `:tada:`                 |
| log          |  🔊   | `:loud_sound:`           |
| lucky        |  🥚   | `:egg:`                  |
| misspelt     |  ✏️   | `:pencil2:`              |
| mobile       |  📱   | `:iphone:`               |
| mute         |  🔇   | `:mute:`                 |
| package      |  📦   | `:package:`              |
| picture      |  📷   | `:camera:`               |
| redesign     |  💄   | `:lipstick:`             |
| relocate     |  🚚   | `:truck:`                |
| remove       |  ➖   | `:heavy_minus_sign:`     |
| screenshot   |  📸   | `:camera_flash:`         |
| security     |  🔒️   | `:lock:`                 |
| seo          |  🔍️   | `:mag:`                  |
| tag/version  |  🔖   | `:bookmark:`             |
| text         |  💬   | `:speech_balloon:`       |
| upgrade      |  ⬆️   | `:arrow_up:`             |
| video        |  🎞️   | `:film_strip:`           |

In addition to the emojis representing these commit types, you can also use other relevant emojis in the commit messages. For example:

```md
👷 build(Electron): Upgrading the version 7 to 9 ⬆️
```

## Commit message cding style

Always format the commit message in Markdown, as Codeberg, GitHub, GitLab, and VSCode support this integration in both the commit message and description. For example:

```md
✨ feat: Adding a new `extends` tag feature
✨ feat(authentication): Implementing `OAuth2` login flow. Closes: #123
🔥 refactor(API): Removing the deprecated **`getUser`** endpoint.
📝 docs(readme): Adding a new section for *Contribution Guidelines*.
```

## Formal English grammar rules for the commit message

- Start the sentences with gerunds, for example:
  - «Checking if the file exists»
  - «Notifying the clients»
  - «Starting the server»
- Use the definite or indefinite articles with nouns at the beginning of sentences or anywhere, for example:
  - «Checking the existence of the `filename.extension`»
  - «Checking the existence of a test»
  - «The `exampleCommand` represents the flags»
  - A flag has been added»
  - «The server failed»
- Use the present continuous tense for actions, for example:
  - «It is creating the SASS files»
  - «The server is running»
- Always use the French quotation marks — `«` and `»` instead of simple or single English quotation marks for articles, special meanings, direct or indirect source. 

You can use an active construction with a gerund or a present perfect passive construction without the gerund, for example:

```md
✨ feat: Adding a new `extends` tag feature.
✨ feat: A new `extends` tag feature has been added.

✨ feat(authentication): Implementing `OAuth2` login flow. Closes: #123
✨ feat(authentication): The `OAuth2` login flow has been implemented. Closes: #123

📝 docs(readme): Adding a new section for *Contribution Guidelines*.
📝 docs(readme): A new section for *Contribution Guidelines* has been added.

👷 build(Electron): Upgrading the version from 7 to 9 ⬆️.
👷 build(Electron): The version has been upgraded from 7 to 9 ⬆️.
```

## Issue Referencing

Th keywords to close an related issue with the commit:

- closing
- fixing
- resolving
- solving

You can use any of these alternatives: `Fixing: #1` or `Fixing #1`. Once the branch is merged into the default branch, the issue will close.

## References

- https://gitmoji.carloscuesta.me/
- http://karma-runner.github.io/1.0/dev/git-commit-msg.html
- https://nitayneeman.com/posts/understanding-semantic-commit-messages-using-git-and-angular/
