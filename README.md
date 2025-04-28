# RITI – Room In The Inn Management System
The RITI project is a Perspective-based application built on Ignition that supports Room In The Inn — a non-profit initiative aimed at helping unhoused individuals access temporary shelter, case management, and essential services.
This is the main desktop project that includes all views, named
queries, styles,
reports and schedule/project script.

## Purpose
RITI serves as the main operational interface for shelter staff and volunteers. It provides tools to:

* Register and manage participants

* Assign shelter locations and beds

* Track services, case notes, and assessments

* Coordinate with partner organizations

* (And more functionalities designed to support day-to-day shelter operations)

This project is part of the broader OpenHMSHub platform and relies on the shared logic from the Global project.

## Project Structure
[Documentation](https://github.com/OpenHMSHub/Documentation/wiki/RITI)

[User Roles and Permissions](https://github.com/OpenHMSHub/Documentation/wiki/User-Roles-and-Permissions)

[ERD](https://github.com/OpenHMSHub/Documentation/wiki/Entity-Relationship-Diagrams)

## Requirements
`Ignition 8.1.47 or later`

SQL Server with [Discovery_Schema.sql](https://github.com/OpenHMSHub/Documentation/blob/main/Discovery_Schema.sql) and [Discovery_Master_Data.sql](https://github.com/OpenHMSHub/Documentation/blob/main/Discovery_Master_Data.sql) loaded

[`Global`](https://github.com/OpenHMSHub/Global) project must be cloned and configured before installing this one

## Installation
[Instalation Guide](https://github.com/OpenHMSHub/Documentation/wiki/Instalation-Guide)

Clone the repository into your Ignition projects folder:

Linux: `/usr/local/bin/ignition/data/projects`

Windows: `C:\Program Files\Inductive Automation\Ignition\data\projects`

```bash
git clone https://github.com/OpenHMSHub/RITI.git
```

Restart your Ignition Gateway.

Ensure that the Global project is present and correctly inherited in the RITI project settings.
In the Ignition Gateway (http://localhost:8088), go to `Config` > `System` > `projects`, and verify that Global is listed as a parent project.

Open a browser and go to:

`http://localhost:8088/data/perspective/client/RITI/`

## Related Projects
[Global](https://github.com/OpenHMSHub/Global)

[WinterShelterPortal](https://github.com/OpenHMSHub/WinterShelterPortal)

[Discovery](https://github.com/OpenHMSHub/Discovery)
