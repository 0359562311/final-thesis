# fakeslink

A fake Slink application written with Flutter framework.


![image](https://user-images.githubusercontent.com/58883494/131202305-ce1fcf09-0719-4805-82d3-0efbc7d3686a.png)

Remember to follow the dependency rule.

App architecture includes 3 main components: domain - data - presentation.

Step by step:
1. start with domain/entities 
  - Determine the necessary entities use in screen such as (User in profile)
  - The entity only carries the data and some get, set or toString() function.
2. domain/repositories
  - All repositories in this folder must be abstract (define needed function to use in that screen)
3. domain/use-cases
  - need to create a use case class for each function in each repository.
4. Move to data/models
  - Each model is a subclass of an entities
  - just need to add some function such as from json here
5. data/repositories
  - Each repository is a subclass of a domain/repositoy
  - in this repository we need data source (remote, local)
  - implement function defined in domain/repository and decide what source we need data from (almost is just remote source), local source is for caching.
6. data/sources
  - make some request with remote source or query local database with local source then return model or collection of model
7. presentation/ controller (bloc, provider,...) 
8. presentation/ ui
