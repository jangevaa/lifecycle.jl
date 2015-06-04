# Load required packages

using DataFrames, Distributions, Gadfly, FishABM


# Specify stock assumptions:
#
# * Age specific mortality
# * Age at 50% maturity
# * Age specific fecundity
# * Carrying capacity (total adults)
# * Compensatory strength - fecundity
# * Compensatory strength - age at 50% maturity
# * Compensatory strength - adult natural mortality
# * Age specific catchability

s_a = StockAssumptions([0.50, 0.50, 0.50, 0.50, 0.50, 0.50, 0.50],
                       5,
                       [2500, 7500, 15000, 20000, 22500, 27500, 32500],
                       2,
                       0.25,
                       1,
                       [0.00001, 0.00002, 0.000025, 0.000025, 0.000025, 0.000025, 0.000025])


# Specify environment assumptions:
# * Spawning areas
# * Habitat types
# * Risk areas

e_a = EnvironmentAssumptions(readdlm(Pkg.dir("FishABM")"/examples/LakeHuron_1km_spawning.csv", ',', Bool)[150:end, 200:370],
                             readdlm(Pkg.dir("FishABM")"/examples/LakeHuron_1km_habitat.csv", ',', Int)[150:end, 200:370],
                             readdlm(Pkg.dir("FishABM")"/examples/LakeHuron_1km_risk.csv", ',', Bool)[150:end, 200:370])

pad_environment!(e_a)


# Specify agent assumptions:
# * Weekly natural mortality rate (by habitat type in the rows, and stage in the columns)
# * Weekly risk mortality (by stage)
# * Stage length (in weeks)
# * Movement weight matrices
# * Movement autonomy

a_a = AgentAssumptions([[0.90 0.10 0.10]
                        [0.10 0.10 0.10]
                        [0.90 0.10 0.10]
                        [0.90 0.90 0.10]
                        [0.90 0.90 0.90]
                        [0.90 0.90 0.90]],
                        [0.0, 0.0, 0.0],
                        [19, 52, 104],
                        Array[[[0. 0. 0.]
                               [0. 1. 0.]
                               [0. 0. 0.]]
                              [[2. 4. 2.]
                               [1. 5. 2.]
                               [1. 1. 2.]]
                              [[2. 4. 2.]
                               [1. 4. 2.]
                               [1. 1. 2.]]],
                        [0., 0.2, 0.8])


# Initialize stock database:
# * Initial population distribution
# * Empty harvest dataset

s_db = StockDB(DataFrame(age_2=100000,
                         age_3=50000,
                         age_4=40000,
                         age_5=30000,
                         age_6=20000,
                         age_7=10000,
                         age_8=100000),
               DataFrame(age_2=Int[],
                         age_3=Int[],
                         age_4=Int[],
                         age_5=Int[],
                         age_6=Int[],
                         age_7=Int[],
                         age_8=Int[]))


# Begin life cycle simulation, specifying:
# * Simulation length (years)
# * Annual fishing effort (vector with length matching the simulation length)
#
# And indicating the previously specified objects:
# * Stock database
# * Stock assumptions
# * Agent assumptions
# * Environment assumptions

a_db = simulate(2, fill(0., 2), rand(Normal(500000, 100000),2), s_db, s_a, a_a, e_a, false, true)

# Visualize agent movement, specify:
# * Environment assumption object
# * Agent database (as generated by simulation)
# * Cohort

# Export images of all plots (for later compilation into an animation, perhaps)
agentplots = plot_agents(e_a, a_db, 1)
for i = 1:length(agentplots)
    draw(PNG(Pkg.dir("FishABM")"/examples/plots/agent_$i.png", 17.3cm, 40cm), agentplots[i])
end

# Visualize stock age distribution through time
stockplot=plot_stock(s_db)
draw(PNG(Pkg.dir("FishABM")"/examples/plots/population.png", 20cm, 15cm), stockplot)
