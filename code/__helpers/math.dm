/proc/clamp(var/value,var/min,var/max)
	return max(min,min(value,max))

/proc/floor(x, y=1)
	return round(x,y)

/proc/ceiling(x, y=1)
	return -round(-x / y) * y

/proc/scale(value,min,max)
	return (value - min) / (max - min)

/proc/arctan(x,y)
	if(!x && !y)
		return 0

	var/a = arccos(x/sqrt(x*x+y*y))

	return (y>=0) ? (a):(-a)


// Clamps (duh) a number between 2 other numbers.
// Yes, this implementation is faster than a min(max()) clamp, I've profiled it.
#define Clamp(x, min, max) (x <= min ? min : (x >= max ? max : x))
#define CLAMP01(x)         Clamp((x), 0, 1)
