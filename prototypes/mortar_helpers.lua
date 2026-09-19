local mortar_help = {}

function mortar_help.makeStreamProjectile(attributes)
    local softSmokeName = attributes.softSmokeName or "smoke-fast"--or makeSmokeSoft(attributes)
    local name = attributes.name .. "-stream-rampant-arsenal"

    data:extend(
        {
            {
                type = "stream",
                name = name,
                flags = {"not-on-map"},
				hidden = true,
				hidden_in_factoriopedia = true,
                --stream_light = {intensity = 1, size = 4},
                --ground_light = {intensity = 0.8, size = 4},

                particle_buffer_size = 90,
                particle_spawn_interval = 1,
                particle_spawn_timeout = 1,
                particle_vertical_acceleration =  0.005 * 0.60 * 0.9, --x
                particle_horizontal_speed = 0.2* 0.75 * 1.5 * 1.5, --x
                particle_horizontal_speed_deviation = 0.005 * 0.70,
                particle_start_alpha = 0.5,
                particle_end_alpha = 1,
                particle_alpha_per_part = 0.8,
                particle_scale_per_part = 0.8,
                particle_loop_frame_count = 15,
                --particle_fade_out_threshold = 0.95,
                particle_fade_out_duration = 2,
                particle_loop_exit_threshold = 0.25,
                -- special_neutral_target_damage = {amount = 1, type = "acid"},
                initial_action = attributes.actions,

                particle = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
                    line_length = 5,
                    width = 42, --22
                    height = 164, --84
                    frame_count = 15,
                    --shift = util.mul_shift(util.by_pixel(-2, 30), 1),
                    shift = util.mul_shift(util.by_pixel(-2, 31), 1),
                    tint = { r=0,g=0,b=0,a=1 },
                    priority = "high",
                    scale = 0.2,
                    animation_speed = 1,
                },
                spine_animation = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
                    line_length = 5,
                    width = 132, --66,
                    height = 20, --12,
                    frame_count = 15,
                    --shift = util.mul_shift(util.by_pixel(0, -2), 1),
                    shift = util.mul_shift(util.by_pixel(0, -1), 1),
                    tint = { r=0,g=0,b=0,a=1 },
                    priority = "high",
                    scale = 0.2,
                    animation_speed = 1,
                },
                shadow = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
                    line_length = 15,
                    width = 42, --22,
                    height = 164, --84,
                    frame_count = 15,
                    priority = "high",
                    --shift = util.mul_shift(util.by_pixel(-2, 30), 1),
                    shift = util.mul_shift(util.by_pixel(-2, 31), 1),
                    draw_as_shadow = true,
                    scale = 0.2,
                    animation_speed = 1,
                },

                oriented_particle = true,
                shadow_scale_enabled = true,
            }
        }
    )
    return name
end

return mortar_help