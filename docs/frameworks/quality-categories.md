# Quality Assessment Framework

> **Reference Material**: This document is loaded conditionally when quality assessment is needed.
> It is NOT part of the core initialization protocol.

---

## Core Categories for Every Task

### 1. Legal & Regulatory Compliance
- Industry-specific regulations
- Data protection laws (GDPR, CCPA, etc.)
- Licensing requirements
- Contractual obligations
- Liability concerns

### 2. Security
- Authentication/Authorization
- Data encryption (in transit and at rest)
- Injection vulnerabilities
- Access control
- Security best practices for the domain
- Threat modeling considerations

### 3. Performance & Efficiency
- Load time optimization
- Resource utilization
- Scalability requirements
- Caching strategies
- Database query optimization
- Memory management

### 4. Maintainability & Code Quality
- Code readability
- Documentation standards
- Naming conventions
- DRY principle adherence
- Technical debt implications
- Testing coverage requirements

### 5. Accessibility
- WCAG compliance
- Screen reader compatibility
- Keyboard navigation
- Color contrast requirements
- Mobile responsiveness
- Language/localization support

### 6. User Experience (UX)
- Usability patterns
- Error message clarity
- User feedback mechanisms
- Intuitive workflows
- Device compatibility
- Browser compatibility

### 7. Testing & Quality Assurance
- Unit test coverage
- Integration testing needs
- End-to-end testing
- Performance testing
- Security testing
- Edge case identification

### 8. Scalability
- Horizontal vs vertical scaling
- Database scaling strategy
- Load balancing
- Future growth considerations
- Rate limiting needs

### 9. Documentation
- Code comments where needed
- README files
- API documentation
- Setup/deployment instructions
- Architecture diagrams
- Decision logs

### 10. Dependencies & Third-Party Tools
- License compatibility
- Maintenance status
- Security track record
- Version management
- Vendor lock-in risks
- Open source considerations

### 11. Data Privacy & Protection
- PII handling
- Data retention policies
- GDPR/privacy compliance
- Anonymization requirements
- Audit trails
- User consent mechanisms

### 12. Error Handling & Edge Cases
- Graceful degradation
- Exception handling
- Input validation
- Boundary conditions
- Recovery mechanisms
- Logging strategy

### 13. Monitoring & Observability
- Logging requirements
- Performance metrics
- Error tracking
- User analytics (compliant)
- System health checks
- Alert thresholds

### 14. Backwards Compatibility
- API versioning strategy
- Database migration paths
- Deprecation timelines
- Breaking change management
- Legacy system integration

### 15. Industry Best Practices
- Current architectural patterns
- Design patterns
- Technology selection rationale
- Community standards
- Latest tooling and frameworks

### 16. Cost & Resource Optimization
- Infrastructure costs
- Licensing costs
- Development time efficiency
- Resource allocation
- ROI considerations
- Technical debt vs delivery speed

### 17. Deployment & DevOps
- Environment parity
- CI/CD pipeline requirements
- Rollback procedures
- Blue-green deployment
- Containerization considerations
- Infrastructure as Code

### 18. Disaster Recovery & Business Continuity
- Backup strategies
- Failover mechanisms
- Recovery time objectives (RTO)
- Recovery point objectives (RPO)
- Data redundancy
- Incident response plan

### 19. Internationalization (i18n) & Localization (l10n)
- Multi-language support
- Character encoding
- Date/time formatting
- Currency handling
- Regional compliance

### 20. Sustainability & Environmental Considerations
- Energy efficiency (where relevant)
- Algorithmic efficiency
- Carbon footprint (for large-scale systems)
- Resource waste minimization

---

## Usage Instructions

When this framework is loaded, the agent should:

1. **Reference this framework** and identify which categories apply
2. **Flag assumptions** - Point out what isn't specified and ask clarifying questions
3. **Check latest documentation** - Don't rely on outdated knowledge
4. **Challenge requirements respectfully** - Suggest better approaches based on these considerations
5. **Highlight risks** - Identify compliance, security, or maintenance issues before they become problems
6. **Propose alternatives** - Offer multiple valid approaches with trade-offs explained
7. **Document reasoning** - Explain why certain decisions align with these categories

## Priority Assessment

Not all categories apply equally to every task. When assessing:
- Identify which categories are **HIGH** priority for the specific task
- Flag **MEDIUM** priority items that should be considered
- Note **LOW** priority items that may not apply
- Explain the priority assessment reasoning
