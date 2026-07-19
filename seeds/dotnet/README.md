# .NET Project Seed

Use this seed when creating a new .NET project from the template.

## Files to Add After Init

```bash
dotnet new sln -n MyApp
dotnet new webapi -n MyApp.Web
dotnet new xunit -n MyApp.Tests
dotnet sln add MyApp.Web MyApp.Tests
```

## Template Notes

- `AI_CONTEXT.md` — Update stack to "C# / .NET 10 / ASP.NET Core"
- `.gitignore` — Already handles bin/obj/ patterns
- `docs/architecture.md` — Document your clean/vertical architecture
