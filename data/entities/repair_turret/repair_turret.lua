local util = require("data/tf_util/tf_util")
local shared = require("shared")
local name = shared.entities.repair_turret
local repair_range = require("shared").repair_range

local turret = util.copy(data.raw.roboport.roboport)
util.recursive_hack_scale(turret, 0.5)

local path = util.path("data/entities/repair_turret/")

local picture = {layers = {
  {
    filename = path.."repair_turret.png",
    width = 330,
    height = 261,
    frame_count = 1,
    direction_count = 1,
    shift = {3/2, -1.8/2},
    scale = 0.5
  },
  {
    filename = path.."repair_turret_mask.png",
    flags = { "mask" },
    line_length = 1,
    width = 122,
    height = 102,
    axially_symmetrical = false,
    direction_count = 1,
    frame_count = 1,
    shift = util.by_pixel(-4/2, -1/2),
    tint = {g = 1, r = 0.5, b = 0.5},
    scale = 0.5
    --apply_runtime_tint = true
  }
}}

local animation =
{
  filename = "__base__/graphics/entity/roboport/hr-roboport-base-animation.png",
  priority = "medium",
  width = 83,
  height = 59,
  frame_count = 8,
  animation_speed = 0.4,
  shift = {0, -2.5},
  scale = 0.66,
  run_mode = "backward"
}

turret.name = name
turret.localised_name = {name}
turret.logistics_radius = 0
turret.construction_radius = repair_range
turret.robot_slots_count = 0
turret.material_slots_count = 1
turret.charging_offsets = {}
turret.charging_energy = "0W"
turret.energy_usage = "0W"
turret.energy_source =
{
  type = "void"
}
turret.collision_box = util.area({0,0}, 0.9)
turret.selection_box = util.area({0,0}, 1)
turret.working_sound = nil
turret.base = picture
turret.base_animation = animation
turret.base_patch = util.empty_sprite()
turret.recharging_animation = util.empty_sprite()
turret.door_animation_down = util.empty_sprite()
turret.door_animation_up = util.empty_sprite()

local item = util.copy(data.raw.item.roboport)
item.name = name
item.localised_name = {name}
item.place_result = name

local beam = util.copy(data.raw.beam["laser-beam"])
util.recursive_hack_tint(beam, {g = 1})
beam.damage_interval = 10000
beam.name = "repair-beam"
beam.localised_name = "repair-beam"
beam.action = nil

data:extend
{
  turret,
  item,
  beam
}