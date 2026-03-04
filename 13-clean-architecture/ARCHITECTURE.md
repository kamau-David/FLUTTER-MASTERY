# Why Feature-First + Layered Architecture

## The problem with `lib/screens`, `lib/models`, `lib/widgets`
As an app grows past a handful of screens, working on ONE feature (say,
"tasks") means jumping between `lib/screens/tasks_screen.dart`,
`lib/models/task.dart`, `lib/providers/tasks_provider.dart` - files related
to the same feature are scattered across the whole codebase. Deleting a
feature means hunting down files in 4+ different folders.

## Feature-first fixes the scattering problem
Group everything about ONE feature together:
```
lib/features/tasks/
```
Now deleting the tasks feature is (almost) just deleting one folder.
Onboarding a new contributor to "just the tasks feature" means pointing
them at one directory.

## The layers WITHIN each feature (domain/data/presentation)
This is a SEPARATE, complementary idea - it's about dependency direction:

- **domain/**: pure business models and rules. No Flutter, no database
  imports. This is your most STABLE code - it rarely changes even if you
  swap Hive for Supabase or switch state management libraries.
- **data/**: implementations that talk to the outside world (Hive, HTTP,
  Supabase). Depends on domain, but domain never depends on it.
- **presentation/**: UI + state management (widgets, Riverpod providers).
  Depends on domain (uses Task) and depends on data only through
  ABSTRACT interfaces (TaskRepository), never concrete implementations directly.

## The payoff
- Swapping your data source (like your own Mongo -> Supabase migration on
  Dr. Marurui Pharmacy) touches ONLY the data/ folder - domain and
  presentation don't change at all.
- Testing presentation logic means providing a fake TaskRepository - no
  real database needed, tests run fast.
- New team members (or club members you're teaching) can be handed exactly
  one feature folder and understand it without reading the whole app.
