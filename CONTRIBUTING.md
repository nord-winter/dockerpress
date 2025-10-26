# Contributing to DockerPress

Thank you for considering contributing to DockerPress! 🎉

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected behavior
- Actual behavior
- Your environment (OS, Docker version, etc.)

### Suggesting Features

Feature suggestions are welcome! Please create an issue with:
- Clear description of the feature
- Use cases
- Potential implementation ideas

### Pull Requests

1. Fork the repository
2. Create a new branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Guidelines

- Follow existing code style
- Update documentation for any changes
- Test your changes with `docker-compose up`
- Keep commits atomic and well-described
- Update README.md if needed

### Testing

Before submitting a PR:

```bash
# Clean start
docker-compose down -v
docker-compose up -d

# Check all services are running
docker-compose ps

# Check logs for errors
docker-compose logs
```

### Documentation

- Update README.md for new features
- Add comments for complex configurations
- Keep both English and Russian versions in sync

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn and grow

## Questions?

Feel free to open an issue or discussion if you have any questions!

Thank you for contributing! 🙏
