# Scratch Project Git Template

This is a Git repository template that allows you to meaningfully track changes in Scratch projects. It includes a `Makefile` that can extract, format and rebuild your Scratch files, along with a `pre-commit` hook to automate it.

## Getting Started

### Prerequisites

<details>
	<summary>To use this template, you need to have these tools available on your system. They are usuallly all pre-installed.</summary>

- [`Git`](https://git-scm.com/), obviously.
- [`Make`](https://www.gnu.org/software/make/), the backbone of this project. It can run the commands this template provides. Usually pre-installed.
- `md5sum`: A command-line tool for calculating MD5 hashes. Comes with [`coreutils`](https://www.gnu.org/software/coreutils/), which is usually pre-installed.
- [`zip`](https://infozip.sourceforge.net/): Needed to zip and unzip Scratch projects. Usually pre-installed.

</details>

For JSON formatting, you need to have [`prettier`](https://prettier.io/) installed.

### Setup

1. [Create a new repository using this template](https://github.com/new?template_name=Scratch&template_owner=moritztim) and click the green `<> Code` button to clone the repository. Click on the question mark icon there if you're unsure how to do this. You will find the same README there.
2. Enable the `.githooks` directory by running the following command in the terminal to change your Git configuration for this repository:
   ```bash
   git config core.hooksPath .githooks
   ```
3. Edit the [`Makefile`](Makefile) to change the `NAME` (if you want to manage a sprite instead of a project, also change the `TYPE` to `sprite`). More information on the environment variables in [ENVIRONMENT.md](ENVIRONMENT.md).
4. If you want to enable formatting, you need to remove a `#` in [`.githooks/pre-commit`](.githooks/pre-commit). Open it in a text editor and you'll find instructions there.

### Usage

1. [Create a new Scratch project](https://scratch.mit.edu/projects/editor/) or open an existing one.
2. Select `File` > `Save to your computer` on the website. (If you want to manage a sprite, right-click on the sprite and select `Export`.)
3. Save the file in `bin/` and name it according to the `NAME` you set in the `Makefile`, keeping the extension.
4. Next time you make a git commit, the file will be extracted and optionally formatted. You can also manually trigger this from the terminal by running:
   ```bash
   make extract
   ```
   or, if you have [`prettier`](https://prettier.io/) installed and want to format the json file:
   ```bash
   make extract format
   ```
5. To generate a new project/sprite file from the extracted files, run `make build`.

## File Structure

<details>
	<summary>Scratch related Files</summary>

You can modify the file structure in the [`Makefile`](Makefile). By default it looks like this: | File | Description | | - | - | | [`src/assets/83a9787d4cb6f3b7632b4ddfebf74367.wav`](src/assets/83a9787d4cb6f3b7632b4ddfebf74367.wav) | **Asset files like sounds and images.** You can rename and edit these but the next time you extract, they will show up with a cryptic name again. You can even delete them after running `make build` once, since this copies them to [`bin/assets/`](bin/assets/). That way you can keep only the ones that you're actually going to change. | | [`src/project.json`](src/project.json) or [`src/sprite.json`](src/sprite.json) | **The main Data file. This tracks changes to the project or sprite** and can even allow you to fine tune some values. Don't go crazy with this though as it can easily cause undefined behavior after building and opening the project in Scratch. | | [`bin/project.sb3`](bin/) or [`bin/sprite1.sb3`](bin/) | **The compressed Scratch project or sprite file.** This will be named according to the `NAME` you set in the `Makefile`. You can upload this to Scratch by selecting `File` > `Load from your computer` on the website. If you didn't mess with it, it will work with no compromises. | | [`bin/assets/83a9787d4cb6f3b7632b4ddfebf74367.wav`](bin/assets/83a9787d4cb6f3b7632b4ddfebf74367.wav) | **Automatically generated files.** These are the files that are created when you run `make build`. They are copies of the files in [`src/assets/`](src/assets/) but with the correct names. You may delete them if you keep the respective files in [`src/assets/`](src/assets/) but they will be recreated when you run `make build`. |

</details>
<details>
	<summary>Other Files</summary>

| File | Description |
| --- | --- |
| [`Makefile`](Makefile) | **The main file that contains all the commands.** You can modify its variables to change the file structure or add new commands for your own needs. |
| [.githooks/pre-commit](.githooks/pre-commit) | **A simple shell script that runs `make` before every commit.** You can modify it to toggle formatting. It will only run if you enable it acording to the [setup instructions](#setup). |
| [README.md](README.md) | **Instructions for using this template.** You should replace this with your own. |
| [LICENSE](LICENSE) | **The terms of the template's License.** For more information, read the file. |
| [`bin/.gitkeep`](bin/.gitkeep) | **A placeholder** because git doesn't track empty directories. You can remove it. |
| [.gitignore](.gitignore) | **A note for git** to ignore the `bin/` directory, since it only contains redundant files that are derived from the `src/` directory. |

</details>

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

[^1]: You may also modify any lines starting with `#`, since they're just comments.
[^2]: [Scratch Wiki on Projects](https://en.scratch-wiki.info/wiki/Project)
[^3]: [Scratch Wiki on Sprites](https://en.scratch-wiki.info/wiki/Sprite)
[^4]: [Scratch Wiki on Sharing Projects](https://en.scratch-wiki.info/wiki/Sharing_projects)
[^5]: [Scratch Wiki on Assets](https://en.scratch-wiki.info/wiki/Scratch_File_Frmat#Assets)
[^7]: [Scratch Wiki on the Scratch File Format](https://en.scratch-wiki.info/wiki/Scratch_File_Format)
[^6]: [Scratch Wiki on Project Files](https://en.scratch-wiki.info/wiki/Scratch_File_Format#Project_Files)
[^8]: [Scratch Wiki on Sprite Files](https://en.scratch-wiki.info/wiki/Scratch_File_Format#Sprite_Files)
