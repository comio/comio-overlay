# Projject Conventions

## Build Command

```bash
ebuild package-version.ebuild digest # Refresh the Manifest file
sudo ebuild package-version.ebuild clean # Clean the build directory
sudo ebuild package-version.ebuild compile # Compile the package
sudo ebuild package-version.ebuild install # Install the package
sudo ebuild package-version.ebuild merge # Merge the package
```

To ensure the quality and integrity of the package, it is important to follow the above commands in the specified order.

After any package-versione.ebuild file modification:
    - you must recalculate the Manifest file using the `digest` command
    - clean the build directory using the `clean` command

If required, you can also compile, install, and merge the package using the respective commands.

## Architecture and directory structure

The packages are organized into two level directory structure, following the pattern:

```txt
<category>/<package-name>/<package-name>-<version>.ebuild
```

Where version is a dotted number, e.g. 1.0.0, 2.3.4, etc., eventually followed by a revision suffix, e.g. 1.0.0-r1, 2.3.4-r2, etc.

## Coding Style

The coding style for the ebuild files follows the Gentoo ebuild guidelines. Some key points include:
    - Use lowercase letters for package names and categories.
    - Use hyphens to separate words in package names.

See the following guidelines for more details:
    - [Quickstart ebuild guide](https://devmanual.gentoo.org/quickstart/)
    - [Basic guide to write Gentoo Ebuilds](https://wiki.gentoo.org/wiki/Basic_guide_to_write_Gentoo_Ebuilds)
    - [Gentoo Policy Guide](https://projects.gentoo.org/qa/policy-guide/)
    - [Master index](https://devmanual.gentoo.org/)
    - [The Ultimate Guide to EAPI 8](https://mgorny.pl/articles/the-ultimate-guide-to-eapi-8.html)

## Commit Message Conventions

When committing changes to the repository, follow these conventions for commit messages:
    - Use a clear and concise subject line that summarizes the change
    - Provide a detailed description of the change in the body of the commit message
    - Reference any relevant issues or pull requests in the commit message
    - The commit message should be in English and follow the standard format of:
        - category/package-name: [subject]
        - [body]
    - If you just upgrade a package, you can use the following format:
        - category/package-name: Bump to version x.y.z

## Gentoo-Specific Considerations

- Architecture handling must match Gentoo's keyword system
- Error messages should be Gentoo-user friendly
- Types should work well with Gentoo's package management concepts
- Consider integration with Portage and other Gentoo tools