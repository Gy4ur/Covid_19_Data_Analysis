/*
Covid 19 Data Exploration 
*/

SELECT *
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY location
	,DATE

-- Select Data that we are going to be starting with

SELECT location
	,DATE
	,total_cases
	,new_cases
	,total_deaths
	,population
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY location
	,DATE

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT location
	,DATE
	,total_cases
	,total_deaths
	,(total_deaths / total_cases) * 100 AS Death_Percentage
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY location
	,DATE

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT location
	,DATE
	,population
	,total_cases
	,(total_cases / population) * 100 AS Infected_Percentage
FROM Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY location
	,DATE

-- Countries with Highest Infection Rate compared to Population

SELECT location
	,population
	,max(total_cases)
	,(total_cases / population) * 100 AS Infected_Percentage
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Infected_Percentage DESC

-- Countries with Highest Death Count per Population

SELECT location
	,population
	,max(total_deaths)
	,(total_deaths / population) * 100 AS Death_Percentage
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Death_Percentage DESC

-- BREAKING THINGS DOWN BY CONTINENT
-- Showing contintents with the highest death count

SELECT continent
	,population
	,max(total_deaths) AS Total_Death_Count
FROM Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Total_Death_Count DESC

-- GLOBAL NUMBERS

SELECT SUM(new_cases) AS TotalCases
	,SUM(new_deaths) AS TotalDeaths
	,SUM(new_deaths) / SUM(new_cases) * 100 AS DeathPercentage
FROM Covid_Deaths
WHERE continent IS NOT NULL

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT CD.continent
	,CD.location
	,CD.DATE
	,CD.population
	,CV.people_vaccinated
	,(CV.people_vaccinated / CD.population) * 100 AS vaccinated_percentage
FROM Covid_Deaths CD
JOIN Covid_Vaccinations CV ON CD.location = CV.location
	AND CD.DATE = CV.DATE
WHERE CD.continent IS NOT NULL
ORDER BY CD.location
	,CD.DATE

-- Creating View to store data for later visualizations


CREATE VIEW PercentPopulationVaccinated
AS
SELECT CD.continent
	,CD.location
	,CD.DATE
	,CD.population
	,CV.new_vaccinations
	,CV.people_vaccinated
	,(CV.people_vaccinated/CD.population)*100 AS vaccinated_percentage
FROM Covid_Deaths CD
JOIN Covid_Vaccinations CV ON cd.location = cv.location
	AND cd.DATE = cv.DATE
WHERE cd.continent IS NOT NULL

DROP VIEW PercentPopulationVaccinated