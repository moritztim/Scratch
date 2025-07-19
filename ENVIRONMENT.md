# Makefile Environment Variables

> Settings can be changed by editing the quoted values. The quotes must be kept. Spaces are allowed, special characters are not. To reference other variables, wrap them like $(THIS) and use their exact name.

## Customizable Project-Specific Settings

> Unless you know what you're doing, only edit this section (marked by ===) in the `Makefile`.[^1] If you do know what you're doing, consider making a fork of the template!

### Metadata

#### `NAME` = `Project`

The name of your project or sprite. This will be used to name the final Scratch file[^6].

Spaces are allowed.

#### `TYPE` = `project`

Must be either `project`[^2] or `sprite`[^3], in lowercase.

#### `PROJECT_ID` = ""

This number can be found in the URLs related to the project. For example: <a href="https://scratch.mit.edu/projects/1105131011/editor" target="_blank"> https://scratch.mit.edu/projects/`1105131011`/editor</a> If the project is not "shared", you need to be logged in as the author to see it. If other users find your project ID, they will not be able to tell that there even is a project with this ID unless you have "shared" it. [^4]

### Project Structure

This section reflects your project's directory structure. If you modify the values, make sure your actual directories match these names, and vice versa. These paths are relative to the place from where you run the `make` commands.

If you want to point to subdirectories, use `/` to separate them, for example: `directory/subdirectory`. Do not include a leading `/` or `./` or a trailing `/`.

#### `SRC_DIR` = `src`

Where the source files are stored. This is where your `project.json` or `sprite.json` file will be.

#### `ASSETS_DIR` = `assets`

Where the asset files, i.e. sounds and costumes are stored.[^5].

#### `OUT_DIR` = `bin`

Where the output files are stored. This is where the final scratch file[^6] will be created.

### `OUT_FILE_LOCATION` = `$(OUT_DIR)`

This is the directory where the final scratch file[^6] will be created. If you want it to be directly in the project root, set it to `.`. If you change this to be outside of the [`OUT_DIR`](#out_dir), make sure to add your custom location to the `.gitignore` file, so that it doesn't get committed to the repository. If there are other files in this directory, that you do want in your repository, you need to add the exact file path to the `.gitignore` file, as defined by [`OUT_FILE`](#out_file).

## Scratch Website

### `SCRATCH_BASE_URL` = `"https://scratch.mit.edu"`

Base URL of the Scratch website.

### `SCRATCH_PROJECT_URL` = `$(SCRATCH_BASE_URL)/projects/$(SCRATCH_PROJECT_ID)`

URL of the project page on the Scratch website.

## Scratch File Format

This is based on the external specification of the Scratch file format[^7].

#### `ZIP_ASSETS_DIR` = `$(OUT_DIR)/assets`

Where the asset files are stored after building the project. This is where the final asset files will be copied to. This will be reflected in the final scratch file[^6].

#### `ZIP_JSON_FILE` = `$(TYPE).json`

Base name of the JSON file that will be created in the `$(OUT_DIR)` directory. It will be named `project.json` or `sprite.json` depending on the value of `TYPE`.

#### `OUT_FILE_EXTENSION` ≈ `sb3` or `sprite3`

The file extension of the final Scratch file[^6]. This changes depending on the value of `TYPE`: `sb3`[^7] for `project`s and `sprite3`[^8] for `sprite`s.

#### `OUT_FILE` = `$(OUT_DIR)/$(NAME).$(OUT_FILE_EXTENSION)`

The path (including the file name) of the final scratch file[^6].

#### `HASH_ALGORITHM` = `md5`

The algorithm used to calculate the hashes of asset files.

### Commands

### `FORMAT_COMMAND` = `prettier --write`

The command used to format the `project.json` or `sprite.json` file. To run this for every commit, remove the `#` before `format` in `.githooks/pre-commit`.

### `OPEN_BROWSER_COMMAND` = `xdg-open`

The command used to open the project in the browser. This can be any command that takes a URL as its only argument.

### `MAKE_COMMAND` = `make`

The command used to run the `Makefile`.

### `HASH_COMMAND` = `$(HASH_ALGORITHM)sum`
The command used to invoke the hash algorithm[^5] to calculate the hash of asset files.

### `REMOVE_EXTRA_SLASHES_COMMAND` = `sed -E "s|(.*)//([^/]*)$$|\1/\2|"`

The command used to remove extra slases from the path of a given URL.

[^1]: You may also modify any lines starting with `#`, since they're just comments.
[^2]: [Scratch Wiki on Projects](https://en.scratch-wiki.info/wiki/Project)
[^3]: [Scratch Wiki on Sprites](https://en.scratch-wiki.info/wiki/Sprite)
[^4]: [Scratch Wiki on Sharing Projects](https://en.scratch-wiki.info/wiki/Sharing_projects)
[^5]: [Scratch Wiki on Assets](https://en.scratch-wiki.info/wiki/Scratch_File_Frmat#Assets)
[^7]: [Scratch Wiki on the Scratch File Format](https://en.scratch-wiki.info/wiki/Scratch_File_Format)
[^6]: [Scratch Wiki on Project Files](https://en.scratch-wiki.info/wiki/Scratch_File_Format#Project_Files)
[^8]: [Scratch Wiki on Sprite Files](https://en.scratch-wiki.info/wiki/Scratch_File_Format#Sprite_Files)
