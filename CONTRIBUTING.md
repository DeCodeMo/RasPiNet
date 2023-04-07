# Contributing

######Thank you for your interest in contributing to RasPiNet!

##### Contributions to RasPiNet are welcome!
*`!` Before doing so, please read this guide.*

*`!` All contributions come under the respective licences detailed in the repository. See the `LICENSE` file for more details.*

*`!` Ensure that the `Code of Conduct` is reviewed prior to making contributions.* 

## Issues

* To report an issue use the `Issues` tab on the main RasPiNet repository. 
  * Issues currently have the follwing templates. 

1) **Bug Reports**
2) **Feature Requests**

*`!` More issue templates may be released if needed. Contact Admin on the discord page to provide suggestions.* 

## Reporting Bugs

* To report a bug, please create an issue on the GitHub issues page.

  * Please check that the issue has not already been reported. If one already exists, you can add to the
discussion there.

  * If an issue does not already exist, please create one. 

* See below for more advice on how to write a good issue.

## Requesting Features

* New features can be requested by creating an issue, with a description of what is wanted. Please
include as much detail as possible. For example, add an example of the code you would like to be
able to write.

  * As with bug reports, please first check that the feature has not already been requested.

  * See below for details about how to write a good issue.

## Where to get help

* Other questions that aren't bugs or feature requests are best asked on the discord
server. 
* Invite Link: [RasPiNet Discord Server](https://discord.gg/qqDBNQGpBM)
* Alternatively, you can manually create an issue and label it as a "question".

## Writing a Good Issue

Basic guidelines:
 * **One issue per topic**
   * For bugs/requests with multiple features, create one issue for each of them.
 * **Check if an issue for the bug/feature already exists**. 
   * Try to avoid creating duplicates.
 * **Check If the issue is related to other issues** 
   * Issues can be linked by using `#issue-number` in a comment. Reference the GitHub Issues documentation for more information. 

## Workflow for Contributing

The following details a rough workflow from reporting a bug/issue, to writing code, and getting your changes merged using a Pull Request.
 1) **Submit the issue ticket**
    * After an issue is submitted, it will be triaged and routed accordingly. 
    * Note that if the contributing guide or process was not followed, it may be removed or you will be asked to fix it. Mistakes happen but follow the instructions so developers can promply add the feature or fix the bug. 
 2) **Make a plan**
     * Use markdown checklists to lay it out prior to coding
 3) **Create a new branch**
     * Follow the eguidlines of `ghuser\issue-num_issue-name
     * Link the branch to the issue
 4) **Write the code**
     * If you are an outside contributor, create a fork of the repository and make your changes on a
       branch in that fork.
     * If you are a kRPC dev team member with write access to the repository, create a branch in the
       repository directly (without forking). See below for details on best practices for
       branches. You should also "assign" the issue to yourself, to indicate that you are actively
       working on the issue.
 5) **Submit a `Draft` Pull Request**
     * Include a brief description of the changes in the Pull Request description.
     * Link the Pull Request to the relevant issue, if one exists. This allows us to match up the
       design discussions with the eventual implementation.
     * If you are an outside contributor, please check the “allow repository maintainer to make
       changes to this branch”. This allows members of the dev team to make small changes to your
       Pull Request if necessary.
 6) **Verify the workflow and tests**
     * Once the Pull Request has been submitted, automated tests will be run using GitHub Actions 
    * Verify the changes do not break anything. These need to pass before the Pull Request can be
    merged.
 7) **Wait for Developer Review**
    * A member of the RasPiNet dev team will then review the changes in the Pull Request. They will provide
    constructive feedback, propose changes, and/or ask for clarification on parts that are not
    clear. This is an iterative process, and may take some time for larger Pull Requests. Once the
    reviewer is happy that the changes are ready to be merged they will approve the Pull Request.
 8) **Merge the Pull Request**
    * The Pull Request can then be merged into the main branch and the Pull Request marked as
    complete. If the related Issue is resolved by the Pull Request, that can also be marked as
    complete.
 9)  **Close the Issue**
        * Finally, the Pull Request and related issue should be added to the next release milestone, so that we can keep track of which changes are in the next release.

## Git Repository Guidelines 
 * The main branch is the latest "bleeding edge" version, and should always be fully compilable and
   functional.
 * The main branch is "protected". Changes can only be merged to it by following the Pull Request
   workflow detailed above.
 * Experimental changes or in-progress work should be done on a branch.
 * Branches should be named `<username>/<issue number>-<issue name>`. For example `gdcosmo/432-fix-build-script`. This
   makes it clear who created the branch, to avoid conflicts.
  
## Writing Code

* Use descriptive variable, function, and method names. Avoid using single-character names or abbreviations.
* Use whitespace to separate logical blocks of code, such as functions and classes.
* Use comments to explain complex sections of code or to provide context for code changes.
* Follow the project's existing code style and conventions. If in doubt, ask for guidance from project maintainers.
* Use proper syntax and follow the language-specific style guidelines.
* Remove unnecessary comments or code before submitting a pull request.
* Use consistent naming conventions for files, directories, and code elements.
* Write clear commit messages that summarize the changes made and explain why they were made.


