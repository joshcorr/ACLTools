# Introduction

### Thanks for using ACLTools!

>First off, thank you for using ACLTools and considering contributing to ACLTools.

This module is far from perfect, and of course needs assistance in being a great tool for any user. It started out as an internal tool used for quickly removing specific access from a file share that constantly got ransomware. It also served as a journey to understand how ACLs work in PowerShell. It has attemted to bridge a gap between Get-Acl and Set-Acl by providing parameter validation for all of the rights that can be given to a file or folder.

### What we are looking for...

Really any assistance.
- Improving documentation
- bug triaging
- writing tutorials
- writing tests
- making it work with PScore (linux and mac)
- new features

# Ground Rules
Just to make sure we are all on the same page here are some guidelines for Pull Requests (PR) in this project.

Responsibilities
* All PRs to Development must have an issue
* PRs must pass PSscriptAnalyzer and Pester tests before being merged
* New functions must have accompanied tests
* Keep PRs limited to as few files as possible (if major change 1-to-1 PR)

# Your First Contribution
If this is your first time contributing to an opensource project, welcome! Here are some helpful tips for your first PR.

* Look for items marked as "good first issue" (these usually only require a few easy changes)
* Comment on this issue to let us know you want to work on it.
* Fork ACLTools into your on repo
* Create a feature branch off of the development branch
    Call it something like `fix-bad-example-issue43`
* If you get stuck reach out for help
* Once you have it the way you like it. Submit a PR against development.

If you are still a little lost check out:
 [Your First Pull Request from Dbatools](https://github.com/sqlcollaborative/dbatools/wiki/Your-First-Pull-Request).


# Reporting a bug

When filing an issue, make sure to answer these five questions:

1. What version of ACLtools are you using?
2. What operating system and processor architecture are you using?
3. What did you do?
4. What did you expect to see?
5. What did you see instead?


###### More to come
I got a lot of great ideas for this guide from [here](https://github.com/nayafia/contributing-template/blob/master/CONTRIBUTING-template.md)