
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

import git

from os import path
import sys

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
    "user" : "gbellocchi",
    "repo" : "hwpe-gen-app"
}

'''
    User Git repositories.
        - https ~ HTTPS URL associated with repo .
        - ssh ~ SSH URL associated with repo.
'''

git_repos = {
    "gitlab_iis": {
        "https" : "https://iis-git.ee.ethz.ch/" + user["user"] + "/" + user["repo"] + ".git", 
        "ssh"   : "git@iis-git.ee.ethz.ch:" + user["user"] + "/" + user["repo"] + ".git"
    },
    "github": {
        "https" : "https://github.com/" + user["user"] + "/" + user["repo"] + ".git", 
        "ssh"   : "git@github.com:" + user["user"] + "/" + user["repo"] + ".git" 
    },
}

'''
   Variables declaration.
'''

name_user       =   user["user"]
name_repo       =   user["repo"]

local_git_dir   =   sys.argv[1] + '/git-deploy'
local_git_repo  =   local_git_dir+'/'+name_repo

https_repo      =   git_repos["github"]["https"]
ssh_repo        =   git_repos["github"]["ssh"]
is_ssh_url      =   1
remote_url      =   ssh_repo if is_ssh_url else https_repo

'''
    Instantiate Git repo item.
'''

target_repo = git.Repo

'''
    Search for remote repository, otherwise initialize a new one.
'''

repo_exists=1
res_remote = lsremote(remote_url)

if(not path.exists(local_git_repo)):
    if(res_remote is repo_exists):
        print('>> Cloning remote repository for at:', local_git_repo)
        try:
            target_repo.clone_from(remote_url, local_git_repo)
        except:
            pass
    else:
        try:
            print('>> Initializing local repository for ', name_repo, ' at:', local_git_repo)
            target_repo.init(local_git_repo)
        except:
            pass
else:
    print('A local repository for', name_repo, 'already exists at:' ,local_git_repo)

'''
    Search for remote or local branch, otherwise create a new one.
'''

r = target_repo(local_git_repo)
print(r)

'''
    Checkout to the target application branch and search for existing 
    files, otherwise deploy the generated ones.
'''