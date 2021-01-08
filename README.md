# Vue 3 + HTTPS + Windows + VS Code + Debugging

Vue debugging does work in Windows through VS Code and Chrome, but I really struggled to get it working with the guides that I found. I'm not saying that they aren't good guides, but there are a few things that were not totally clear to me, so hopefully this guide will fill in the gaps.

## Prerequisites

1. [PowerShell 7+](https://github.com/PowerShell/PowerShell/releases) - this isn't completely necessary, but it is a really nice terminal and feels significantly more Unix-like than `cmd.exe` or the previous generation of PowerShell.

   To use PowerShell as the default shell in the VS Code terminal you need to paste the following line into your user settings file.

    ```json
    "terminal.integrated.shell.windows": "C:\\Program Files\\PowerShell\\7\\pwsh.exe
    ```

2. [Anaconda](https://www.anaconda.com/products/individual) - again you don't absolutely need Anaconda, however it provides an easy way to get specific versions of applications and run them side by side and means that you can (almost) exactly replicate my environment.

## NodeJS in Anaconda

Once you have Anaconda installed you will need to initialize it so that it can be used from the command line. This should be as simple as opening a PowerShell prompt and issuing the command:

```powershell
> conda init powershell
```

The most recent versions of Anaconda should work out of the box in PowerShell 7+, but if not you can try [this guide](https://hackf5.medium.com/how-to-enable-anaconda-in-powershell-7-on-windows-394ba62c3f9c).

I am going to use NodeJS 12 because Vue raises some warnings if you use a more recent version:

```powershell
> conda create --name node12
> conda activate node12
> conda install -c conda-forge nodejs=12.19.0 
```

## The Vue CLI

I'm going to use the [Vue CLI](https://cli.vuejs.org/guide) to scaffold my Vue project, this is an easy way of getting a basic Vue "Hello World!" up and running.

```powershell
>  npm install -g @vue/cli
```

## Create the Vue App

Most guides start by initializing an app in the root folder of the VS Code workspace, but this doesn't really represent how most real codebases are structured, and due to the fiddly nature of the Vue debugging setup I'm going to go nest the app below the root.

So open a command prompt somewhere that you want to create your workspace and issue the following command.

```powershell
> mkdir vue-project
> cd vue-project
> code .
```

This will open the folder `vue-project` as a new VS Code workspace. From now on you can use the VS Code terminal, but don't forget to use activate the `node12` conda environment before you work with node.

```powershell
> conda activate node12
```

From the terminal create a directory to hold the app

```powershell
> mkdir www/main
> cd www/main
```

Now you can scaffold the Vue App.

```powershell
> vue create app
```

Choose the default Vue 3 option which might be called `Default (Vue 3 Preview)`. After it has finished generating you can try running the app.

```powershell
> cd app
> npm run serve
```

This will display the url that point to your app, which is probably `http://localhost:8080/`, ctrl + click on this to see it running.

