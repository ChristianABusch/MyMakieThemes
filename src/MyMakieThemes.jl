module MyMakieThemes

using CairoMakie
using MathTeXEngine
using Colors

standard_theme_colors = [parse(Colorant, c) for c in ["#dd3218", "#19a525", "#1b55cf", "#b75fb3", "#000000"]]

const unit_to_pt = Dict(
    :mm => 2.83,
    :cm => 28.3,
    :pt => 1,
    :inch => 72,
)

function get_theme(;
    unit =:mm,
    resolution = (85, 60),
    fontsize = 12,
    figure_padding = 15,
    colors = standard_theme_colors,
    Nxminorticks = 2,
    Nyminorticks = 2
    )

    spine_width = 0.75

    theme = Theme(;
        CairoMakie = (pt_per_unit = 1, px_per_unit = 4),
        GLMakie    = (px_per_unit = 1,),
        resolution = resolution .* unit_to_pt[unit],
        fontsize,
        figure_padding,
        palette = (
            color  = colors, 
            marker = Cycle([:circle, :rect, :utriangle]),
        ),
        Lines = (
            linewidth = 1.25,
            linestyle = :solid,
        ),
        Scatter = (
            markersize = 6,
        ),
        Legend = (
            patchsize    = (20.0, 5.0), 
            rowgap       = 5, 
            framewidth   = spine_width, 
            framevisible = false,
            padding      = (5.0, 5.0, 3.0, 3.0)
        ),
        Axis = (
            xgridvisible       = false,
            ygridvisible       = false,
            xminorticksvisible = true,
            yminorticksvisible = true,
            xticksize          = 4,
            yticksize          = 4,
            xminorticksize     = 2,
            yminorticksize     = 2,
            xminorticks        = IntervalsBetween(Nxminorticks),
            yminorticks        = IntervalsBetween(Nyminorticks),
            spinewidth         = spine_width,
            xtickwidth         = spine_width,
            ytickwidth         = spine_width,
            xminortickwidth    = spine_width,
            yminortickwidth    = spine_width,
        )
    )
    merge!(theme, theme_latexfonts())
    return theme
end

export get_theme, standard_theme_colors
end