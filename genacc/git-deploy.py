'''
 =====================================================================
 Project:      GenAcc
 Title:        git-deploy.py
 Description:  Automatic deployment of generated accelerators to Git.

 Date:         22.11.2021
 =====================================================================

 Copyright (C) 2021 University of Modena and Reggio Emilia..

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

 Modules:
    - GitPython ~ Reference documentation: https://gitpython.readthedocs.io/en/stable/index.html
'''

import git

from emitter import emitter

from os import path
import sys
import shutil

'''
    GitDeploy class
    ===============

    This class is to automate the process of cataloging of generated accelerators in the cloud.
    In particular, GitHub/gitLab repositories can be targeted for this purpose. This solution is 
    helpful in the phase of managing the many different accelerators the user might want to test,
    deploy, etc. since most of the RTL source management tools (e.g. Bender) are strongly coupled
    to Git repositories, being Git-based solutions.

    The proposed flow requires a Git user account to be specified. Generated accelerators can thus
    be pushed to the cloud targeting an application-specific branch. Once this is done, the user
    can invoke the accelerator components using Bender to target simulation or synthesis.
'''

class git_deploy(emitter):
    """
    Create environment for hardware.
    """
    def user_dict(self):
        pass
'''
    Functions
    =========

    This function is equivalent to 'git ls-remote'
'''

def lsremote(url):
    remote_refs = {}
    g = git.cmd.Git()
    try:
        for ref in g.ls_remote(url).split('\n'):
            hash_ref_list = ref.split('\t')
            remote_refs[hash_ref_list[1]] = hash_ref_list[0]
        return 1 # repo exists
    except:
        return 0 # repo does not exist

'''
    Dictionaries
    ============

    User information.
        - user ~ Git username.
        - repo ~ Name of Git repository.
'''

user = {
    "author"            : "Gianluca Bellocchi",
    "email"             : "gianluca.bellocchi@unimore.it",
    "user"              : "gbellocchi",
}

app = {
    "repo"              : "hwpe-gen-app",
    "kernel"            : "conv_mdc"
}

'''
    User Git repositories.
        - https ~ HTTPS URL associated with repo .
        - ssh ~ SSH URL associated with repo.
'''

git_repos = {
    "gitlab_iis"        : {
        "https"         : "https://iis-git.ee.ethz.ch/" + user["user"] + "/" + app["repo"] + ".git", 
        "ssh"           : "git@iis-git.ee.ethz.ch:" + user["user"] + "/" + app["repo"] + ".git"
    },
    "github": {
        "https"         : "https://github.com/" + user["user"] + "/" + app["repo"] + ".git", 
        "ssh"           : "git@github.com:" + user["user"] + "/" + app["repo"] + ".git" 
    },
}

'''
   Variables declaration
   =====================
'''

name_user       =   user["user"]
name_repo       =   app["repo"]

local_git_dir   =   sys.argv[1] + '/git-deploy'
local_git_repo  =   local_git_dir+'/'+name_repo

https_repo      =   git_repos["github"]["https"]
ssh_repo        =   git_repos["github"]["ssh"]
is_ssh_url      =   1
remote_url      =   ssh_repo if is_ssh_url else https_repo

'''
    Instantiate Git repo item
'''

git_g           = git.Git()
git_target      = git.Repo
git_author      = git.Actor(user["author"], user["email"])
git_committer   = git_author

'''
    Clone remote repository
'''

repo_exists     = 1
res_remote      = lsremote(remote_url)

if(not path.exists(local_git_repo)):

    # ============================ #
    # remote exists, local not exist
    # ============================ #

    if(res_remote is repo_exists):

        print('>> Cloning remote repository for at:\n\t', local_git_repo)

        # try cloning application-specific branch
        try:
            git_target.clone_from(
                remote_url, 
                local_git_repo,
                branch=app["kernel"]
            )

        # otherwise clone the master
        except:
            git_target.clone_from(
                remote_url, 
                local_git_repo,
                branch="master"
            )

    # ========================= #
    # remote exists, local exists
    # ========================= #

else:
    print('A local repository for', name_repo, 'already exists at:\n\t' ,local_git_repo)

'''
    Search for remote (or local) application-specific branch, otherwise create a new one
'''

print(git_target.active_branch)


# '''
#     Emitter
#     =======

#     Instantiate export item
# '''
# emitter         = emitter()

# '''
#     Search for existing files, otherwise deploy the generated ones.
# '''

# print('>> Git deployment')

# source          = emitter.out_hw_outdir
# destination     = local_git_repo + '/hw'
# shutil.copytree(source, destination)

# source          = emitter.out_ov_integr
# destination     = local_git_repo + '/integr_support'
# shutil.copytree(source, destination)

# source          = emitter.out_sw_outdir
# destination     = local_git_repo + '/sw'
# shutil.copytree(source, destination)

# '''
#     Commit generated wrapper.
# '''

# index = repo.index

# # print('>> Adding untracked files')
# # repo.index.add([
# #     local_git_repo + '/hw',
# #     local_git_repo + '/integr_support',
# #     local_git_repo + '/sw'
# # ])

# repo.git.add(all=True)

# print('>> First commit')
# index.commit("First commit.", author=git_author, committer=git_committer)

# # # # puskh and pull behaves similarly to `git push|pull`
# # origin.pull()
# # origin.push()
# # # assert not empty_repo.delete_remote(origin).exists()     # create and delete remotes