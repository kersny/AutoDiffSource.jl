δplus{T}(x::T, y::T) = (x+y, z->(z, z))
δminus{T}(x::T, y::T) = (x-y, z->(z, -z))
δtimes(x::AbstractFloat, y::AbstractFloat) = (x*y, z->(z*y, z*x))
δdivide(x::AbstractFloat, y::AbstractFloat) = (t = x/y; (t, z->(z/y, -z*t/y)))
δpower(x::AbstractFloat, y::AbstractFloat) = (t = x^y; (t, z->(z*y*t/x, z*t*log(x))))

δminus(x) = (-x, z->-z)
δabs(x) = (abs(x), z->z*sign(x))
δsum(x::AbstractFloat) = (x, z->z)
δsum(x) = (t = size(x); (sum(x), z->fill(z, t)))
δsqrt(x) = (t = sqrt(x); (t, z->0.5*z/t))
δexp(x) = (t = exp(x); (t, z->z*t))
δlog(x) = (log(x), z->z/x)

δdotplus{T}(x::T, y::T) = (x.+y, z->(z, z))
δdotminus{T}(x::T, y::T) = (x.-y, z->(z, -z))
δdottimes{T}(x::T, y::T) = (x.*y, z->(z.*y, z.*x))
δdotdivide{T}(x::T, y::T) = (t = x./y; (t, z->(z./y, -z.*t./y)))
δdotpower{T}(x::T, y::T) = (t = x.^y; (t, z->(z.*y.*t./x, z.*t.*log.(x))))
δdotabs(x) = (abs.(x), z->z.*sign.(x))
δdotsqrt(x) = (t = sqrt.(x); (t, z->0.5*z./t))
δdotexp(x) = (t = exp.(x); (t, z->z.*t))
δdotlog(x) = (log.(x), z->z./x)

δplus(x::AbstractFloat, y::AbstractArray) = (x+y, z->(sum(z), z))
δplus(x::AbstractArray, y::AbstractFloat) = (x+y, z->(z, sum(z)))
δminus(x::AbstractFloat, y::AbstractArray) = (x-y, z->(sum(z), -z))
δminus(x::AbstractArray, y::AbstractFloat) = (x-y, z->(z, -sum(z)))
δtimes(x::AbstractFloat, y::AbstractArray) = (x*y, z->(sum(z.*y), z.*x))
δtimes(x::AbstractArray, y::AbstractFloat) = (x*y, z->(z.*y, sum(z.*x)))
δdivide(x::AbstractArray, y::AbstractFloat) = (t = x/y; (t, z->(z/y, -sum(z.*t./y))))

δdotplus(x::AbstractVector, y::AbstractMatrix) = (x.+y, z->(sum(z, 2), z))
δdotplus(x::AbstractMatrix, y::AbstractVector) = (x.+y, z->(z, sum(z, 2)))
δdotplus(x::AbstractFloat, y::AbstractArray) = (x.+y, z->(sum(z), z))
δdotplus(x::AbstractArray, y::AbstractFloat) = (x.+y, z->(z, sum(z)))

δdotminus(x::AbstractVector, y::AbstractMatrix) = (x.-y, z->(sum(z, 2), -z))
δdotminus(x::AbstractMatrix, y::AbstractVector) = (x.-y, z->(z, -sum(z, 2)))
δdotminus(x::AbstractFloat, y::AbstractArray) = (x.-y, z->(sum(z), -z))
δdotminus(x::AbstractArray, y::AbstractFloat) = (x.-y, z->(z, -sum(z)))

δdottimes(x::AbstractVector, y::AbstractMatrix) = (x.*y, z->(sum(z.*y, 2), z.*x))
δdottimes(x::AbstractMatrix, y::AbstractVector) = (x.*y, z->(z.*y, sum(z.*x, 2)))
δdottimes(x::AbstractFloat, y::AbstractArray) = (x.*y, z->(sum(z.*y), z.*x))
δdottimes(x::AbstractArray, y::AbstractFloat) = (x.*y, z->(z.*y, sum(z.*x)))

δdotdivide(x::AbstractVector, y::AbstractMatrix) = (t = x./y; (t, z->(sum(z./y, 2), -z.*t./y)))
δdotdivide(x::AbstractMatrix, y::AbstractVector) = (t = x./y; (t, z->(z./y, -sum(z.*t./y, 2))))
δdotdivide(x::AbstractFloat, y::AbstractArray) = (t = x./y; (t, z->(sum(z./y), -z.*t./y)))
δdotdivide(x::AbstractArray, y::AbstractFloat) = (t = x./y; (t, z->(z./y, -sum(z.*t)/y)))

δdotpower(x::AbstractVector, y::AbstractMatrix) = (t = x.^y; (t, z->(sum(z.*y.*t./x, 2), z.*t.*log.(x))))
δdotpower(x::AbstractMatrix, y::AbstractVector) = (t = x.^y; (t, z->(z.*y.*t./x, sum(z.*t.*log.(x), 2))))
δdotpower(x::AbstractFloat, y::AbstractArray) = (t = x.^y; (t, z->(sum(z.*y.*t)/x, z.*t.*log.(x))))
δdotpower(x::AbstractArray, y::AbstractFloat) = (t = x.^y; (t, z->(z.*y.*t./x, sum(z.*t.*log.(x)))))

δplus_1(x, y) = (x+y, z->z)
δplus_2(x, y) = (x+y, z->z)
δminus_1(x, y) = (x-y, z->-z)
δminus_2(x, y) = (x-y, z->z)
δtimes_1(x, y) = (x*y, z->(z*x))
δtimes_2(x, y) = (x*y, z->(z*y))
δdivide_1(x, y) = (t = x/y; (t, z->(-z*t/y)))
δdivide_2(x, y) = (x/y, z->(z/y))
δpower_1(x, y) = (t = x^y; (t, z->z*t*log(x)))
δpower_2(x, y) = (t = x^y; (t, z->z*y*t/x))

δdotplus_1(x, y) = (x.+y, z->z)
δdotplus_2(x, y) = (x.+y, z->z)
δdotminus_1(x, y) = (x.-y, z->-z)
δdotminus_2(x, y) = (x.-y, z->z)
δdottimes_1(x, y) = (x.*y, z->(z.*x))
δdottimes_2(x, y) = (x.*y, z->(z.*y))
δdotdivide_1(x, y) = (t = x./y; (t, z->(-z.*t./y)))
δdotdivide_2(x, y) = (x./y, z->(z./y))
δdotpower_1(x, y) = (t = x.^y; (t, z->z.*t.*log(x)))
δdotpower_2(x, y) = (t = x.^y; (t, z->z.*y.*t./x))

δfanout(x) = (x..., (z...) -> [z...])

macro fanouts(n)
    name = Symbol("∇fanout$n")
    nabla = :(function $name(); []; end)
    name = Symbol("δfanout$n")
    delta = :(function $name(x); (); end)

    for k = 1:n
        push!(nabla.args[1].args, :($(Symbol("x$k"))))
        push!(nabla.args[2].args[2].args, :($(Symbol("x$k"))))
        push!(delta.args[2].args[2].args, :(x[$k]))
    end
    push!(delta.args[2].args[2].args, nabla)
    esc(delta)
end

for k in 2:12
    @eval @fanouts $k
end
