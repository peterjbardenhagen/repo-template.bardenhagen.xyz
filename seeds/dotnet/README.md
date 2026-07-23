# .NET Project Seed

Use this seed when creating a new .NET project from the template.

## Files to Add After Init

```bash
dotnet new sln -n MyApp
dotnet new webapi -n MyApp.Web
dotnet new xunit -n MyApp.Tests
dotnet sln add MyApp.Web MyApp.Tests
```

## Template Integration Checklist

- [ ] Run `bash scripts/init-project.sh <project-name>` or use GitHub template clone
- [ ] `dotnet new sln -n MyApp && dotnet new webapi -n MyApp.Web`
- [ ] `dotnet new xunit -n MyApp.Tests && dotnet sln add MyApp.Tests`
- [ ] Update `AI_CONTEXT.md` — stack to "C# / .NET 10 / ASP.NET Core"
- [ ] Update `docs/architecture.md` — document clean/vertical slices, layers
- [ ] Add `launchSettings.json` profiles to `.gitignore` (already done)
- [ ] Configure `docker-compose.yml` for SQL Server, Postgres, or test containers
- [ ] Add `Directory.Packages.props` for centralized package management

## Recommended Packages

| Purpose | Package |
|---------|---------|
| Web framework | ASP.NET Core (included) |
| Validation | FluentValidation |
| Authentication | `Microsoft.AspNetCore.Authentication.JwtBearer` |
| ORM | `Microsoft.EntityFrameworkCore` |
| Documentation | `Swashbuckle.AspNetCore` |
| Testing | `xunit`, `FluentAssertions`, `Respawn` |
| Observability | `OpenTelemetry.Extensions.Hosting` |
